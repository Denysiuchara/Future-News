//
//  + Date.swift
//  Future News
//
//  Created by Danya Denisiuk on 14.02.2024.
//

import Foundation

extension Date {
    static func - (recent: Date, previous: Date) -> (year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?) {
        let year = Calendar.current.dateComponents([.year], from: previous, to: recent).year
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        
        return (year: year, month: month, day: day, hour: hour, minute: minute)
    }
    
    func publishingDifference() -> String {
        let currentDate = Date()
        let delta = currentDate - self
        
        if let year = delta.year, year != 0 {
            return "\(year) year\(year == 1 ? "" : "s") ago"
        } else if let month = delta.month, month != 0 {
            return "\(month) month\(month == 1 ? "" : "s") ago"
        } else if let day = delta.day, day != 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        } else if let hour = delta.hour, hour != 0 {
            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
        } else if let minute = delta.minute, minute != 0 {
            return "\(minute) minute\(minute == 1 ? "" : "s") ago"
        } else {
            return "recent"
        }
    }
}
