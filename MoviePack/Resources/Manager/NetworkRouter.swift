//
//  NetworkRouter.swift
//  MoviePack
//
//  Created by 서충원 on 7/1/24.
//

import Foundation
import Alamofire

enum Network {
    case kobis(date: String)
    case kobisSearch(word: String, year: String)
    case search(word: String, page: Int)
    case trend
    case detail(id: Int)
    case credit(id: Int)
    case similar(id: Int, page: Int)
    case recommend(id: Int, page: Int)
    case poster(id: Int)
    case video(id: Int)
    
    var baseURL: String {
        switch self {
        case .kobis:
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/"
        default:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    var endPoint: String {
        switch self {
        case .kobis:
            return baseURL + "boxoffice/searchDailyBoxOfficeList.json"
        case .kobisSearch:
            return baseURL + "search/movie"
        case .search:
            return baseURL + "search/movie"
        case .trend:
            return baseURL + "trending/movie/week"
        case .detail(let id):
            return baseURL + "movie/\(id)"
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
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .kobis(let date):
            return ["key": APIKey.kobisKey, "targetDt": date]
        case .kobisSearch(let word, let year):
            return ["api_key": APIKey.TMDBKey, "language": "en-US", "query": word, "year": year]
        case .search(let word, let page):
            return ["api_key": APIKey.TMDBKey, "language": "ko-KR", "query": word, "page": page]
        case .trend:
            return ["api_key": APIKey.TMDBKey, "language": "ko-KR"]
        case .detail:
            return ["api_key": APIKey.TMDBKey, "language": "ko-KR"]
        case .credit:
            return ["api_key": APIKey.TMDBKey, "language": "ko-KR"]
        case .similar(_, let page):
            return ["api_key": APIKey.TMDBKey, "language": "ko-KR", "page": page]
        case .recommend(_, let page):
            return ["api_key": APIKey.TMDBKey, "language": "ko-KR", "page": page]
        case .poster:
            return ["api_key": APIKey.TMDBKey]
        case .video:
            return ["api_key": APIKey.TMDBKey]
        }
    }
}
