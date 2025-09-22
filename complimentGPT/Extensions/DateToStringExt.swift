//
//  DateToStringExt.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/21/25.
//



import Foundation

extension String {
    static func timeAgoString(from date: Date) -> String {
        let secondsAgo = Int(Date().timeIntervalSince(date))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 30 * day
        switch secondsAgo {
        case 0..<minute:
            return "\(secondsAgo) sec ago"
        case minute..<hour:
            return "\(secondsAgo / minute) min ago"
        case hour..<day:
            return "\(secondsAgo / hour) hr ago"
        case day..<week:
            return "\(secondsAgo / day) day ago"
        case week..<month:
            return "\(secondsAgo / week) week ago"
        case month..<(month * 12):
            return "\(secondsAgo / month) month ago"
        default:
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
    }
}
