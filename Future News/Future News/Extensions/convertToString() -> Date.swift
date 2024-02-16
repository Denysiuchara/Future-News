//
//  converteToString() + Date.swift
//  Future News
//
//  Created by Danya Denisiuk on 14.02.2024.
//

import Foundation

extension Date {
    func convertToString(value: Int = -2, component: Calendar.Component = .day) -> String {
        
        guard let modifiedDate = Calendar.current.date(byAdding: component, value: value, to: self) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: modifiedDate)
    }
}
