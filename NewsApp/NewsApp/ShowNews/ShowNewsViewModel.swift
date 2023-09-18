//
//  ShowNewsViewModel.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 21.08.2023.
//

import Foundation

protocol ShowNewsViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var date: String { get }
    var imageData: Data? { get }
}

final class ShowNewsViewModel: ShowNewsViewModelProtocol {
    let title: String
    let description: String
    let date: String
    let imageData: Data?
    
    init(article: ArticleCellViewModel) {
        title = article.title
        description = article.description
        date = article.date
        imageData = article.imageData
    }
}
