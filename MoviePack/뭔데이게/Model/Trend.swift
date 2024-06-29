//
//  Trend.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import Foundation
import Alamofire

struct TrendResult: Decodable {
    let results: [Trend]
}

struct Trend: Decodable {
    let backdrop_path: String
    let title: String
    let original_title: String
    let release_date: String
    let id: Int
    let overview: String
    let vote_average: Double
    
    var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let date = inputFormatter.date(from: release_date)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yy/MM/dd"
        return outputFormatter.string(from: date!)
    }
    
    var formattedScore: String {
        return String(format: "%.1f", vote_average)
    }
    
    var posterUrl: String {
        return "https://image.tmdb.org/t/p/w780/\(backdrop_path)"
    }
}

struct CreditsResult: Decodable {
    let id: Int
    let cast: [Credits]
    
    init(id: Int = 0, cast: [Credits] = []) {
        self.id = id
        self.cast = cast
    }
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

enum TMDB {
    case trend
    case credit(id: Int)
    case similar(id: Int)
    case recommend(id: Int)
    case poster(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: String {
        switch self {
        case .trend:
            return baseURL + "trending/movie/week"
        case .credit(let id):
            return baseURL + "movie/\(id)/credits"
        case .similar(let id):
            return baseURL + "movie/\(id)/similar"
        case .recommend(let id):
            return baseURL + "movie/\(id)/recommendations"
        case .poster(let id):
            return baseURL + "movie/\(id)/images"
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MmEwZjRkOWVlNzI4YTUzNzJiY2RjOThiYTIxMDE3ZSIsIm5iZiI6MTcxOTQ4NDA2My43NjE0NDMsInN1YiI6IjY2NjExZTVhZTg1NjZiNmE4Y2EyNTcxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mZuAp79W_whTRwVIXpYuUJdvTF3Eq86_L1lR1Rk35LI"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .trend:
            return ["api_key": APIKey.trendKey, "language": "ko-KR"]
        case .credit:
            return ["api_key": APIKey.trendKey, "language": "ko-KR"]
        case .similar:
            return ["api_key": APIKey.trendKey, "language": "ko-KR"]
        case .recommend:
            return ["api_key": APIKey.trendKey, "language": "ko-KR"]
        case .poster:
            return ["api_key": APIKey.trendKey]
        }
    }
}

struct TrendManager {
    
    private init() {}
    
    static let shared = TrendManager()
    
    func trendRequest(router: TMDB, completionHandler: @escaping (TrendResult?, Error?) -> Void) {
        
        AF.request(router.endPoint, method: router.method, parameters: router.parameters, headers: router.header).responseDecodable(of: TrendResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func creditRequest(router: TMDB, completionHandler: @escaping (CreditsResult?, Error?) -> Void) {
        
        AF.request(router.endPoint, method: router.method, parameters: router.parameters, headers: router.header).responseDecodable(of: CreditsResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
