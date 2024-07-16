//
//  Credits.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import Foundation

struct CreditsResult: Decodable {
    let id: Int
    let cast: [Person]
}
