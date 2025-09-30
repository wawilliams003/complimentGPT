//
//  SessionManager.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/30/25.
//

import UIKit

final class SessionManager {
    static let shared = SessionManager()
    private init() {}

    private var timers: [Timer] = []
    private var shownCount = 0
    private let maxPerSession = 4

    /// Call when app becomes active (foreground). Resets counters & schedules all popups.
    func startSession() {
        endSession() // fully reset previous state
        shownCount = 0

        // #1: first popup at 3 seconds
        let first = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            self?.showPromoIfNeeded()
        }
        timers.append(first)

        // #2–#4: spread randomly across a random session between 1–5 minutes total
        scheduleRemainingPopups()
    }

    /// Call when app is going inactive / background. Cancels timers so they don't fire in background.
    func endSession() {
        timers.forEach { $0.invalidate() }
        timers.removeAll()
        shownCount = 0
    }

    private func scheduleRemainingPopups() {
        let minSession: TimeInterval = 60   // 1 min
        let maxSession: TimeInterval = 300  // 5 min
        let sessionLength = TimeInterval.random(in: minSession...maxSession)

        // Divide into 3 segments; place one popup randomly inside each segment.
        let segment = sessionLength / 3.0

        for i in 1...3 {
            let minT = (TimeInterval(i - 1) * segment) + 5  // small buffer after prior event
            let maxT = TimeInterval(i) * segment
            let fire = TimeInterval.random(in: minT...maxT)

            let t = Timer.scheduledTimer(withTimeInterval: fire, repeats: false) { [weak self] _ in
                self?.showPromoIfNeeded()
            }
            timers.append(t)
        }
    }

    private func showPromoIfNeeded() {
        guard shownCount < maxPerSession else { return }

        // Avoid double-present if something is already on screen.
        guard let host = topMostViewController(), host.presentedViewController == nil else { return }

        shownCount += 1
        DispatchQueue.main.async {
            let promoVC = PaymentVC() // <-- your custom VC
            promoVC.modalPresentationStyle = .overFullScreen
            host.present(promoVC, animated: true)
        }
    }

    // MARK: - Utilities

    /// Safely finds the topmost view controller on the key window’s hierarchy.
    private func topMostViewController(
        from root: UIViewController? = {
            let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
            let keyWindow = scenes.first?.windows.first { $0.isKeyWindow }
            return keyWindow?.rootViewController
        }()
    ) -> UIViewController? {
        if let nav = root as? UINavigationController { return topMostViewController(from: nav.visibleViewController) }
        if let tab = root as? UITabBarController { return topMostViewController(from: tab.selectedViewController) }
        if let presented = root?.presentedViewController { return topMostViewController(from: presented) }
        return root
    }
}
