//
//  SearchMoview.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import Foundation
import Alamofire

protocol Results {
    var backdropPath: String? { get }
    var posterUrl: String { get }
}

//MARK: - SearchMovieResult
struct SearchMovieResult: Decodable {
    let page: Int?
    var results: [SearchMovie]
    let totalPages: Int
    let totalResults: Int
    
    init(page: Int? = 0, results: [SearchMovie] = [], totalPages: Int = 0, totalResults: Int = 0) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

//CodingKeys
extension SearchMovieResult {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//MARK: - SearchMovie
struct SearchMovie: Decodable, Results {
    let id: Int?
    let title: String?
    let backdropPath: String?
    var posterUrl: String {
        return "https://image.tmdb.org/t/p/w780/" + (backdropPath ?? "")
    }
}

//CodingKeys
extension SearchMovie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
    }
}

//MARK: - PosterResult
struct PosterResult: Decodable {
    var backdrops: [Poster]
    
    init(backdrops: [Poster] = []) {
        self.backdrops = backdrops
    }
}

struct Poster: Decodable, Results {
    let backdropPath: String?
    var posterUrl: String {
        return "https://image.tmdb.org/t/p/w780/" + (backdropPath ?? "")
    }
}

//CodingKeys
extension Poster {
    enum CodingKeys: String, CodingKey {
        case backdropPath = "file_path"
    }
}

//MARK: - VideoResult
struct VideoResult: Decodable {
    let results: [Video]
    
    init(results: [Video]) {
        self.results = results
    }
}

struct Video: Decodable {
    let key: String
}

struct SearchManager {
    
    static let shared = SearchManager()
    
    private init() { }
    
    func searchRequest<T: Decodable>(router: TMDB, type: T.Type, handler: @escaping (T?) -> ()) {
        AF.request(router.endPoint, method: router.method, parameters: router.parameters, headers: router.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                handler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}


