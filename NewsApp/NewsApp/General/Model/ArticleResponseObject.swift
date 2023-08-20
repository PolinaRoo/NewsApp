//
//  ArticleResponseObject.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 18.08.2023.
//

import Foundation

struct ArticleResponseObject: Codable {
    let title: String
    let description: String
    let urlToImage: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case date = "publishedAt"
    }
}
