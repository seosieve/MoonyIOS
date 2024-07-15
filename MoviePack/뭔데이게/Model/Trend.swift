//
//  Trend.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import Foundation

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
