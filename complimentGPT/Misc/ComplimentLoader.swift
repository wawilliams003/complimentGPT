//
//  ComplimentLoader.swift
//  complimentGPT
//
//  Created by Wayne Williams on 10/1/25.
//

import Foundation

struct NotificationCompliment: Codable {
    let id: Int
    let category: String
    let text: String
}

final class ComplimentLoader {
    static func load(fromFile name: String = "compliments_expanded", ext: String = "json") -> [NotificationCompliment] {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext),
              let data = try? Data(contentsOf: url),
              let list = try? JSONDecoder().decode([NotificationCompliment].self, from: data) else {
            return []
        }
        return list
    }
}

final class DailyComplimentProvider {
    static let shared = DailyComplimentProvider()
    private init() {}

    // UserDefaults keys
    private let orderKey = "compliment.order"
    private let indexKey = "compliment.index"
    private let lastDateKey = "compliment.lastDate"

    private var compliments: [NotificationCompliment] = []
    
    private let calendar = Calendar.current

    func configure(with compliments: [NotificationCompliment]) {
        self.compliments = compliments
        ensureOrderInitialized()
    }

    func todayCompliment() -> NotificationCompliment? {
        guard !compliments.isEmpty else { return nil }

        let today = Date()
        let defaults = UserDefaults.standard

        if let lastDate = defaults.object(forKey: lastDateKey) as? Date,
           calendar.isDate(lastDate, inSameDayAs: today) {
            // Same day, return current index
            let idx = currentIndex()
            return complimentAtOrderedIndex(idx)
        } else {
            // New day -> advance index (and reshuffle if needed)
            var idx = currentIndex()
            idx = idx + 1
            let orderCount = savedOrder().count
            if idx >= orderCount {
                reshuffleOrder()
                idx = 0
            }
            defaults.set(idx, forKey: indexKey)
            defaults.set(today, forKey: lastDateKey)
            defaults.synchronize()
            return complimentAtOrderedIndex(idx)
        }
    }

    // MARK: - Helpers

    private func ensureOrderInitialized() {
        let defaults = UserDefaults.standard
        if savedOrder().isEmpty || savedOrder().count != compliments.count {
            // initialize / reinitialize order if counts don’t match
            let order = Array(0..<compliments.count).shuffled()
            defaults.set(order, forKey: orderKey)
            defaults.set(0, forKey: indexKey)
            defaults.set(Date(), forKey: lastDateKey) // start today at first
            defaults.synchronize()
        }
    }

    private func reshuffleOrder() {
        let order = Array(0..<compliments.count).shuffled()
        let defaults = UserDefaults.standard
        defaults.set(order, forKey: orderKey)
        defaults.synchronize()
    }

    private func savedOrder() -> [Int] {
        UserDefaults.standard.array(forKey: orderKey) as? [Int] ?? []
    }

    private func currentIndex() -> Int {
        UserDefaults.standard.integer(forKey: indexKey)
    }

    private func complimentAtOrderedIndex(_ idx: Int) -> NotificationCompliment? {
        let order = savedOrder()
        guard idx >= 0, idx < order.count else { return nil }
        let originalIdx = order[idx]
        guard originalIdx >= 0, originalIdx < compliments.count else { return nil }
        return compliments[originalIdx]
    }
}
