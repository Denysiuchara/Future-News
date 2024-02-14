//
//  convertToDate + String.swift
//  Future News
//
//  Created by Danya Denisiuk on 14.02.2024.
//

import Foundation

extension String {
    func convertToDate() -> Date {
        let stringDate = self
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: stringDate) {
            print("isoDateFormatter: -> \(dateFormatter)")
            return date
        } else {
            print("convertToDate() does not converted current string")
            return Date()
        }
    }
}
