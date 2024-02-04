//
//  + ApiService.swift
//  Future News
//
//  Created by Danya Denisiuk on 04.02.2024.
//

import Foundation

extension ApiService {
    static func decode<T: Decodable>(data: Data) -> Result<T, Error> {
        do {
            let decodeData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodeData)
        } catch {
            return .failure(error)
        }
    }
}
