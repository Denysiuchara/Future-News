//
//  predicateFormulation() -> NSPredicate.swift
//  Future News
//
//  Created by Danya Denisiuk on 25.02.2024.
//

import Foundation
import CoreData

extension NSPredicate {
    static func predicateFormulation(destination: String,
                                     startDate: Date,
                                     endDate: Date,
                                     selectedPublishers: Set<String>) -> NSCompoundPredicate {
        
        var predicates: [NSPredicate] = []
        
        // Фильтрация по дате публикации
        let datePredicate = NSPredicate(format: "publishDate >= %@ AND publishDate <= %@",
                                        startDate as CVarArg,
                                        endDate as CVarArg)
        predicates.append(datePredicate)
        
        // Фильтрация по значению destination
        if !destination.isEmpty {
            predicates.append(NSPredicate(format: "text CONTAINS[c] %@ OR title CONTAINS[c] %@",
                                          destination,
                                          destination))
        }
        
        // Фильтрация по выбранным издателям
        if !selectedPublishers.isEmpty {
            let publisherPredicates = selectedPublishers.map { NSPredicate(format: "sourceURL == %@", "https://www.\($0)") }
            
            let compoundPublisherPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: publisherPredicates)
            
            predicates.append(compoundPublisherPredicate)
        }
        
        // Объединение и возврат всех предикатов
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}
