//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 18.08.2023.
//

import Foundation

final class ArticleCellViewModel: TableCollectionViewItemsProtocol {
    let title: String
    let description: String
    let imageUrl: String?
    var date: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description ?? ""
        date = article.date
        imageUrl = article.urlToImage ?? ""
        
        if let formatDate = formateDate(dateString: self.date) {
            date = formatDate
        }
    }
    
    private func formateDate(dateString: String) -> String? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormater.date(from: dateString) else { return nil }

        dateFormater.dateFormat = "dd MMM yyyy HH:mm"
        return dateFormater.string(from: date)
    }
}
