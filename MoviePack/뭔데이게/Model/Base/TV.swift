//
//  TV.swift
//  MoviePack
//
//  Created by 서충원 on 7/17/24.
//

import Foundation

struct TV: Decodable, BaseType {
    let id: Int
    let name: String?
    let originalName: String?
    let overview: String?
    let releaseDate: String?
    let grade: Double?
    let genreID: [Int?]?
    let popularity: Double?
    let backdropPath: String?
    var imageUrl: String {
        return "https://image.tmdb.org/t/p/w780/" + (backdropPath ?? "")
    }
}

///CodingKeys
extension TV {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case overview
        case releaseDate = "first_air_date"
        case grade = "vote_average"
        case genreID = "genre_ids"
        case popularity
        case backdropPath = "backdrop_path"
    }
}
