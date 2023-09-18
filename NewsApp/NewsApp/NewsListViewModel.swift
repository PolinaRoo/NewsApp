//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 09.09.2023.
//

import Foundation
import UIKit

protocol NewsListViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var sections: [TableCollectionViewSection] { get }
    
    func makeAlert(titleController: String,
                   messageController: String,
                   titleButton: String) -> UIAlertController
    func loadData(searchText: String?)
}

class NewsListViewModel: NewsListViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((IndexPath) -> Void)?
    var showError: ((String) -> Void)?
    
    //MARK: - Properties
    var sections: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    
    
    var page = 0
    var searchText: String? = nil
    private var isSearchChanged: Bool = false
    
    func loadData(searchText: String? = nil) {
        if self.searchText != searchText {
            page = 1
            isSearchChanged = true
        } else {
            page += 1
            isSearchChanged = false
        }
        self.searchText = searchText
    }
    
    // -MARK: Methods
    func handleResult(result: Result<[ArticleResponseObject], Error>) {
        switch result {
        case .success(let articles):
            self.convertToCellViewModel(articles)
            self.loadImage()
        case .failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
            }
        }
    }
    
    private func loadImage() {
        for (i, section) in sections.enumerated() {
            for (index, item) in section.items.enumerated() {
                if let article = item as? ArticleCellViewModel,
                   let url = article.imageUrl {
                    ApiManager.getImageData(url: url) { [weak self] result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
                                    article.imageData = data
                                }
                                self?.reloadCell?(IndexPath(row: index, section: i))
                            case .failure(let error):
                                self?.showError?(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(titleController: String,
                   messageController: String,
                   titleButton: String) -> UIAlertController  {
        let alert = UIAlertController(title: titleController,
                                      message: messageController,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: titleButton,
                                   style: .default)
        alert.addAction(action)
        
        return alert
    }
    
    func convertToCellViewModel(_ articlesSports: [ArticleResponseObject]) {
        let viewModels = articlesSports.map { ArticleCellViewModel(article: $0) }
        if sections.isEmpty || isSearchChanged {
            let firstSection =  TableCollectionViewSection(items: viewModels)
            sections = [firstSection]
        } else {
            sections[0].items += viewModels
        }
    }
    
    private func setupMockObjects() {
        sections = [
            TableCollectionViewSection(items: [ArticleCellViewModel(article: ArticleResponseObject(title: "First",
                                                                                                   description: "First First First First First First First First ",
                                                                                                   urlToImage: "Fifcffffffrst",
                                                                                                   date: "23.08.2023"))])
        ]
    }
}
