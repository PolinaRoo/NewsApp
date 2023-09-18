//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 07.09.2023.
//

import Foundation

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
}
