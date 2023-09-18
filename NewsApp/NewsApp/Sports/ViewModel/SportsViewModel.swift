//
//  SportsViewModel.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 21.08.2023.
//

import Foundation

final class SportsViewModel: NewsListViewModel {
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getNews(theme: .sports, page: page, searchText: searchText) { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    override func convertToCellViewModel(_ articlesSports: [ArticleResponseObject]) {
        var viewModels = articlesSports.map { ArticleCellViewModel(article: $0) }
        if sections.isEmpty {
            let firstSection =  TableCollectionViewSection(items: [viewModels.removeFirst()])
            let secondSection = TableCollectionViewSection(items: viewModels)
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
}
