//
//  Credits.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import Foundation

struct CreditsResult: Decodable {
    let id: Int
    let cast: [Credits]
}

struct Credits: Decodable {
    let name: String
    let original_name: String
    let profile_path: String?
    let character: String
    var profileUrl: String {
        return "https://image.tmdb.org/t/p/w780/\(profile_path ?? "")"
    }
}
