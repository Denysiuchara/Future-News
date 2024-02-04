//
//  + HTTPURLResponse.swift
//  Future News
//
//  Created by Danya Denisiuk on 04.02.2024.
//

import Foundation

extension HTTPURLResponse {
    var isSuccess: Bool {
        return (200..<300).contains(self.statusCode)
    }
}
