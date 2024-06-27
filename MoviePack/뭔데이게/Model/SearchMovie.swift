//
//  SearchMoview.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import Foundation
import Alamofire

//MARK: - SearchMovieResult
struct SearchMovieResult: Decodable {
    let page: Int?
    var results: [SearchMovie]
    let totalPages: Int
    let totalResults: Int
}

//CodingKeys, Dummy
extension SearchMovieResult {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    static var dummy: SearchMovieResult {
        return SearchMovieResult(page: 0, results: [], totalPages: 0, totalResults: 0)
    }
}

//MARK: - SearchMovie
struct SearchMovie: Decodable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    var posterUrl: String {
        return "https://image.tmdb.org/t/p/w780/" + (backdropPath ?? posterPath ?? "")
    }
}

//CodingKeys, Dummy
extension SearchMovie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
        case posterPath = "file_path"
    }
}

struct SearchResult {
    static let shared = SearchResult()
    
    private init() { }
    
    func searchRequest(url: String, handler: @escaping (SearchMovieResult?) -> ()) {
        AF.request(url).responseDecodable(of: SearchMovieResult.self) { response in
            switch response.result {
            case .success(let value):
                handler(value)
            case .failure(let error):
                print(error)
                
            }
        }
    }
}


