//
//  SportsViewModel.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 21.08.2023.
//

import Foundation

protocol SportsViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class SportsViewModel: SportsViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    
    //MARK: - Properties
    var numberOfCells: Int{
        articlesSports.count
    }
    private var articlesSports: [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    init() {
           loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articlesSports[row]
    }
    
    private func loadData() {
        ApiManager.getNews(theme: .sports) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.articlesSports = self.convertToCellViewModel(articles)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage() {
       // print(#function)
        // TODO: Get imageData
        // Slow
       // guard let url = URL(string: articles[row].imageUrl),
         //     let data = try? Data(contentsOf: url) else { return }
        for (index, article) in articlesSports.enumerated() {
            ApiManager.getImageData(url: article.imageUrl) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articlesSports[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ articlesSports: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articlesSports.map { ArticleCellViewModel(article: $0) }
    }
    
    private func setupMockObjects() {
        articlesSports = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "First",
                                                                description: "First First First First First First First First ",
                                                                urlToImage: "Fifcffffffrst",
                                                                date: "23.08.2023"))
        ]
    }
}

