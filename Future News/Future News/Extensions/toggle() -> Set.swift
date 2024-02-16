//
//  toggle() -> Set.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import Foundation

extension Set {
    mutating func toggle(value: Element) {
        if self.contains(value) {
            self.remove(value)
            print("Toggle method: Removed value: \(value)")
        } else {
            self.insert(value)
            print("Toggle method: Inserted value: \(value)")
        }
    }
}
