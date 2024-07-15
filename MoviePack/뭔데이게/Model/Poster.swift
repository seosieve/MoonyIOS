//
//  Poster.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import Foundation

struct PosterResult: Decodable {
    var backdrops: [Poster]
    var posters: [Poster]
}

struct Poster: Decodable {
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "file_path"
    }
    
    var posterUrl: String {
        return "https://image.tmdb.org/t/p/w780/" + (backdropPath ?? "")
    }
}
