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
        
        let agoKey = NSLocalizedString("ago", comment: "")
        
        let currentDate = Date()
        let delta = currentDate - self
        
        if let year = delta.year, year != 0 {
            switch year {
            case 1:
                return "\(String.localizedStringWithFormat(NSLocalizedString("year_singular", comment: ""), year)) \(agoKey)"
            case 2...4:
                return "\(String.localizedStringWithFormat(NSLocalizedString("year_plural_2_4", comment: ""), year)) \(agoKey)"
            default:
                return "\(String.localizedStringWithFormat(NSLocalizedString("year_plural_5_10", comment: ""), year)) \(agoKey)"
            }
        } else if let month = delta.month, month != 0 {
            switch month {
            case 1:
                return "\(String.localizedStringWithFormat(NSLocalizedString("month_singular", comment: ""), month)) \(agoKey)"
            case 2...4:
                return "\(String.localizedStringWithFormat(NSLocalizedString("month_plural_2_4", comment: ""), month)) \(agoKey)"
            default:
                return "\(String.localizedStringWithFormat(NSLocalizedString("month_plural_5_10", comment: ""), month)) \(agoKey)"
            }
        } else if let day = delta.day, day != 0 {
            switch day {
            case 1:
                return "\(String.localizedStringWithFormat(NSLocalizedString("day_singular", comment: ""), day)) \(agoKey)"
            case 2...4:
                return "\(String.localizedStringWithFormat(NSLocalizedString("day_plural_2_4", comment: ""), day)) \(agoKey)"
            default:
                return "\(String.localizedStringWithFormat(NSLocalizedString("day_plural_5_10", comment: ""), day)) \(agoKey)"
            }
        } else if let hour = delta.hour, hour != 0 {
            switch hour {
            case 1:
                return "\(String.localizedStringWithFormat(NSLocalizedString("hour_singular", comment: ""), hour)) \(agoKey)"
            case 2...4:
                return "\(String.localizedStringWithFormat(NSLocalizedString("hour_plural_2_4", comment: ""), hour)) \(agoKey)"
            default:
                return "\(String.localizedStringWithFormat(NSLocalizedString("hour_plural_5_10", comment: ""), hour)) \(agoKey)"
            }
        } else if let minute = delta.minute, minute != 0 {
            switch minute {
            case 1:
                return "\(String.localizedStringWithFormat(NSLocalizedString("minute_singular", comment: ""), minute)) \(agoKey)"
            case 2...4:
                return "\(String.localizedStringWithFormat(NSLocalizedString("minute_plural_2_4", comment: ""), minute)) \(agoKey)"
            default:
                return "\(String.localizedStringWithFormat(NSLocalizedString("minute_plural_5_10", comment: ""), minute)) \(agoKey)"
            }
        } else {
            return NSLocalizedString("recent", comment: "")
        }
    }
}
