//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 20.08.2023.
//

import Foundation

enum NetworkingError: Error {
    case apiKeyInvalid
    case unknown
    case networkingError(_ error: Error)
}
