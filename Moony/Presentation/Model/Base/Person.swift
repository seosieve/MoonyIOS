//
//  Person.swift
//  Moony
//
//  Created by 서충원 on 7/17/24.
//

import Foundation

struct Person: Decodable, BaseType {
    let id: Int
    let name: String?
    let originalName: String?
    let character: String?
    let popularity: Double?
    let profilePath: String?
    var imageUrl: String {
        return "https://image.tmdb.org/t/p/w780/" + (profilePath ?? "")
    }
}

///CodingKeys
extension Person {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case character
        case popularity
        case profilePath = "profile_path"
    }
}
