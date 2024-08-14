//
//  Search.swift
//  Moony
//
//  Created by 서충원 on 6/11/24.
//

import Foundation

struct SearchResult: Decodable, Hashable {
    let page: Int?
    var results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

///CodingKeys
extension SearchResult {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


