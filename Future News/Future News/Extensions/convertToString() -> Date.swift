//
//  converteToString() + Date.swift
//  Future News
//
//  Created by Danya Denisiuk on 14.02.2024.
//

import Foundation

extension Date {
    //    func convertToStringForView(value: Int = -2, component: Calendar.Component = .day) -> String {
    //
    //        guard let modifiedDate = Calendar.current.date(byAdding: component, value: value, to: self) else {
    //            return ""
    //        }
    //
    //        let dateFormatter = DateFormatter()
    //            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //
    //        return dateFormatter.string(from: modifiedDate)
    //    }
    //
    //    func convertToStringForAPIRequset() -> String {
    //
    //        let dateFormatter = DateFormatter()
    //            dateFormatter.dateFormat = "yyyy-MM-dd HH%3Amm%3Ass"
    //
    //        return dateFormatter.string(from: self)
    //    }
    
    
    // OLD method
    
    func convertToString(value: Int = -2, component: Calendar.Component = .day) -> String {
        guard let modifiedDate = Calendar.current.date(byAdding: component, value: value, to: self) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: modifiedDate)
    }
    
}
