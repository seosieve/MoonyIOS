//
//  Movie.swift
//  Moony
//
//  Created by 서충원 on 7/17/24.
//

import Foundation

struct Movie: Decodable, BaseType, Hashable {
    let id: Int
    let name: String?
    let originalName: String?
    let overview: String?
    let releaseDate: String?
    let grade: Double?
    let popularity: Double?
    let genreID: [Int?]?
    let backdropPath: String?
    let posterPath: String?
    var imageUrl: String {
        let baseUrl = "https://image.tmdb.org/t/p/original/"
        return [backdropPath, posterPath].compactMap { $0 }.first.map { baseUrl + $0 } ?? ""
    }
}

///CodingKeys
extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case originalName = "original_title"
        case overview
        case releaseDate = "release_date"
        case grade = "vote_average"
        case popularity
        case genreID = "genre_ids"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}
