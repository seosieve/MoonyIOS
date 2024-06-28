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

enum RequestType {
    case trend
    case credit(id: Int)
    
    var haveID: Int? {
        switch self {
        case .trend:
            return nil
        case .credit(let id):
            return id
        }
    }
}

struct TrendManager {
    
    private init() {}
    
    static let shared = TrendManager()
    
    func trendRequest(completionHandler: @escaping (TrendResult?, Error?) -> Void) {
        
        let urlString = "https://api.themoviedb.org/3/trending/movie/week"
        
        let param: Parameters = ["api_key": APIKey.trendKey, "language": "ko-KR"]
        
        AF.request(urlString, parameters: param).responseDecodable(of: TrendResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func creditRequest(type: RequestType, completionHandler: @escaping (CreditsResult?, Error?) -> Void) {
        guard let id = type.haveID else { return }
        
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        let param: Parameters = ["api_key": APIKey.trendKey, "language": "ko-KR"]
        
        AF.request(urlString, parameters: param).responseDecodable(of: CreditsResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
