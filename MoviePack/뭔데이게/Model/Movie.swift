//
//  SearchMoview.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import Foundation
import Alamofire

struct MovieResult: Decodable {
    let page: Int?
    var results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

extension MovieResult {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let backdropPath: String?
    let posterPath: String?
    let grade: Double?
    let genreID: [Int?]?
    var posterUrl: String {
        return "https://image.tmdb.org/t/p/w780/" + (backdropPath ?? posterPath ?? "")
    }
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case grade = "vote_average"
        case genreID = "genre_ids"
    }
}


