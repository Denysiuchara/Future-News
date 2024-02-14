//
//  NewsTheme.swift
//  Future News
//
//  Created by Danya Denisiuk on 04.02.2024.
//

import Foundation

extension APIURLConfig {
    enum NewsTheme: String, CaseIterable {
        case allNews = "All news"
        case business = "Business"
        case politics = "Politics"
        case tech = "Tech"
        case science = "Science"
        case games = "Games"
        case sport = "Sport"
    }
}
