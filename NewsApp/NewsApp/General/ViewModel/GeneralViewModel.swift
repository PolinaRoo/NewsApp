//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 18.08.2023.
//

import Foundation

final class GeneralViewModel: NewsListViewModel {
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getNews(theme: .everything,
                           page: page,
                           searchText: searchText) { [weak self] result in
            self?.handleResult(result: result)
        }
    }
}

