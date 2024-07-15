//
//  Kobis.swift
//  MoviePack
//
//  Created by 서충원 on 6/7/24.
//

import Foundation

struct KobisResult: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [KobisRank]
}

struct KobisRank: Decodable {
    let rank: String
    let rankInten: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let audiCnt: String
}
