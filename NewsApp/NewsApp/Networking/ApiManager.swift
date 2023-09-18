//
//  ApiManager.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 20.08.2023.
//

import Foundation

final class ApiManager {
    enum Theme: String {
        case everything = "everything?sources=bbc-news&language=en"
        case sports = "top-headlines?category=sports&country=us"
        case technology = "top-headlines?category=technology&country=us"
        
    }
    
    private static let apiKey = "f336dc57a0f54fcb9e0a9c9b2d58e207"
    private static let baseUrl = "https://newsapi.org/v2/"
    
    //create URL path and make request
    static func getNews(theme: Theme,
                        page: Int,
                        searchText: String?,
                        completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        var searchParameter = ""
        if let searchText = searchText {
            searchParameter = "&q=\(searchText)"
        }
        let stringUrl = baseUrl + theme.rawValue + "&page=\(page)" + searchParameter + "&apiKey=\(apiKey)"
        print(stringUrl)
        guard let url = URL(string: stringUrl) else { return }
        print(url)
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            
            if let error = error {
                print(error)
                completion(.failure(error))
            }
        }
        
        session.resume()
    }
    
    private static func handleResponse(data: Data?, error: Error?,
                                       completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json ?? "")
            
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self,
                                                     from: data)
                completion(.success(model.articles))
            }
            catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
    
}
