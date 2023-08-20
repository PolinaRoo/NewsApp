//
//  NewsResponseObject.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 18.08.2023.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
