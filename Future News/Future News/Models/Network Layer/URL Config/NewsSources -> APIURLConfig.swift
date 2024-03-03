//
//  NewsSources -> APIURLConfig.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.02.2024.
//

import Foundation

extension APIURLConfig {
    //    enum NewsSources: String, CaseIterable {
    //        case cnn = "cnn.com"
    //        case bbc = "bbc.co.uk"
    //        case vox = "vox.com"
    //        case euronews = "euronews.com"
    //        case express = "express.co.uk"
    //        case foxnews = "foxnews.com"
    //        case news24 = "news24.com"
    //        case sydneysun = "sydneysun.com"
    //        case thejapannews = "thejapannews.net"
    //        case cbc = "cbc.ca"
    //        case tass = "tass.com"
    //        case theconversation = "theconversation.com"
    //        case theresident = "theresident.eu"
    //        case timesofsandiego = "timesofsandiego.com"
    //        case news = "9news.com.au"
    //        case newsweek = "newsweek.com"
    //        case abc13 = "abc13.com"
    //        case abc7news = "abc7news.com"
    //        case cnbc = "cnbc.com"
    //        case cpj = "cpj.org"
    //        case kyiv = "kyiv.ua"
    //        case elmundo = "elmundo.es"
    //        case e27 = "e27.co"
    //        case thelocal = "thelocal.com"
    //        case kosovapress = "kosovapress.com"
    //        case krooknews = "krooknews.com"
    //        case stv = "stv.tv"
    //        case google = "google.com"
    //        case apnlive = "apnlive.com"
    //        case autonews = "autonews.com"
    //        case boston = "boston.com"
    //        case businessStandard = "business-standard.com"
    //        case europeantimes = "europeantimes.news"
    //        case mercurynews = "mercurynews.com"
    //        case minnpost = "minnpost.com"
    //        case ozodi = "ozodi.org"
    //        case politico = "politico.eu"
    //        case theworld = "theworld.org"
    //        case euronews247 = "euronews247.com"
    //        case telegraph = "telegraph.co.uk"
    //        case euobserver = "euobserver.com"
    //        case kyivpost = "kyivpost.com"
    //        case reddit = "reddit.com"
    //        case sport = "sport.ua"
    //        case isport = "isport.ua"
    //    }
    
    static let sources: [(name: String, source: String)] = [
        ("CNN", "cnn.com"),
        ("BBC", "bbc.co.uk"),
        ("VOX", "vox.com"),
        ("Euronews", "euronews.com"),
        ("Express", "express.co.uk"),
        ("Foxnews", "foxnews.com"),
        ("News24", "news24.com"),
        ("Sydneysun", "sydneysun.com"),
        ("The Japan News", "thejapannews.net"),
        ("CBC", "cbc.ca"),
        ("Tass", "tass.com"),
        ("The Conversation", "theconversation.com"),
        ("The Resident", "theresident.eu"),
        ("Times of Sandiego", "timesofsandiego.com"),
        ("9News", "9news.com.au"),
        ("Newsweek", "newsweek.com"),
        ("ABC13", "abc13.com"),
        ("ABC7 news", "abc7news.com"),
        ("CNBC", "cnbc.com"),
        ("CPJ", "cpj.org"),
        ("Kyiv.ua", "kyiv.ua"),
        ("Elmundo", "elmundo.es"),
        ("e27", "e27.co"),
        ("The Local", "thelocal.com"),
        ("Kosova Press", "kosovapress.com"),
        ("krooknews", "krooknews.com"),
        ("STV", "stv.tv"),
        ("Google", "google.com"),
        ("APN Live", "apnlive.com"),
        ("Autonews", "autonews.com"),
        ("Boston", "boston.com"),
        ("Business Standard", "business-standard.com"),
        ("European Times", "europeantimes.news"),
        ("Mercury News", "mercurynews.com"),
        ("Minnpost", "minnpost.com"),
        ("Ozodi", "ozodi.org"),
        ("Politico", "politico.eu"),
        ("The World", "theworld.org"),
        ("Euronews 24/7", "euronews247.com"),
        ("Telegraph", "telegraph.co.uk"),
        ("EU Observer", "euobserver.com"),
        ("Kyiv Post", "kyivpost.com"),
        ("Reddit", "reddit.com"),
        ("Sport", "sport.ua"),
        ("Isport", "isport.ua")
    ]
}
