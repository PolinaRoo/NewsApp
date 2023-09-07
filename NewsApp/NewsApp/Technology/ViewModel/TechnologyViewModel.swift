//
//  TechnologyViewModel.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 03.09.2023.
//

import Foundation

protocol TechnologyViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class TechnologyViewModel: TechnologyViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    
    //MARK: - Properties
    var numberOfCells: Int{
        articlesTechnology.count
    }
    private var articlesTechnology: [ArticleCellViewModel] = [] {
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
        return articlesTechnology[row]
    }
    
    private func loadData() {
        ApiManager.getNews(theme: .technology) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.articlesTechnology = self.convertToCellViewModel(articles)
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
        for (index, article) in articlesTechnology.enumerated() {
            ApiManager.getImageData(url: article.imageUrl) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articlesTechnology[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func convertToCellViewModel(_ articlesTechnology: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articlesTechnology.map { ArticleCellViewModel(article: $0) }
    }
    
    private func setupMockObjects() {
        articlesTechnology = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "First",
                                                                description: "First First First First First First First First ",
                                                                urlToImage: "Fifcffffffrst",
                                                                date: "23.08.2023"))
        ]
    }
}

