//
//  TMDBRouter.swift
//  MoviePack
//
//  Created by 서충원 on 7/1/24.
//

import Foundation
import Alamofire

enum TMDB {
    case trend
    case credit(id: Int)
    case similar(id: Int, page: Int)
    case recommend(id: Int, page: Int)
    case poster(id: Int)
    case video(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: String {
        switch self {
        case .trend:
            return baseURL + "trending/movie/week"
        case .credit(let id):
            return baseURL + "movie/\(id)/credits"
        case .similar(let id, _):
            return baseURL + "movie/\(id)/similar"
        case .recommend(let id, _):
            return baseURL + "movie/\(id)/recommendations"
        case .poster(let id):
            return baseURL + "movie/\(id)/images"
        case .video(let id):
            return baseURL + "movie/\(id)/videos"
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
        case .similar(_, let page):
            return ["api_key": APIKey.trendKey, "language": "ko-KR", "page": page]
        case .recommend(_, let page):
            return ["api_key": APIKey.trendKey, "language": "ko-KR", "page": page]
        case .poster:
            return ["api_key": APIKey.trendKey]
        case .video:
            return ["api_key": APIKey.trendKey]
        }
    }
}
