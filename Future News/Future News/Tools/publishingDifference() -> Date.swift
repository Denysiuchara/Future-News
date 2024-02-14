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
        
        if delta.year != 0 {
            return "\(delta.year ?? 0) year's ago"
        } else {
            if delta.month != 0 {
                return "\(delta.month ?? 0) month ago"
            } else {
                if delta.hour != 0 {
                    return "\(delta.hour ?? 0) hour's ago"
                } else {
                    if delta.minute != 0 {
                        return "\(delta.minute ?? 0) minute ago"
                    } else {
                        return "recent"
                    }
                }
            }
        }
    }
}
