//
//  Movie.swift
//  MoviePack
//
//  Created by 서충원 on 6/7/24.
//

import Foundation

struct MovieResult: Decodable {
    let boxOfficeResult: boxOfficeResult
}

struct boxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [Movie]
}

struct Movie: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
