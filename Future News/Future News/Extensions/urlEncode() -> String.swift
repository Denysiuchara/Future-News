//
//  urlEncode() -> String.swift
//  Future News
//
//  Created by Danya Denisiuk on 26.02.2024.
//

import Foundation

extension String {
    func urlEncode() -> String? {
        return self
            .replacingOccurrences(of: " ", with: "%20")
            .replacingOccurrences(of: ".", with: "%2E")
            .replacingOccurrences(of: ",", with: "%2C")
            .replacingOccurrences(of: "?", with: "%26")
            .replacingOccurrences(of: "!", with: "%21")
    }
}
