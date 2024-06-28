//
//  Movie.swift
//  MoviePack
//
//  Created by 서충원 on 6/7/24.
//

import Foundation
import Alamofire

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

struct MovieManager {
    private init() {}
    static let shared = MovieManager()
    
    let urlString = APIURL.movieUrl
    
    func movieRequest(date: Int, completionHandler: @escaping (MovieResult?, Error?) -> Void) {
        AF.request(urlString+String(date)).responseDecodable(of: MovieResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
