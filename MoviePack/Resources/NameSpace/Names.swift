//
//  Names.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import Foundation

enum Names {
    enum Noti {
        static let rank = Notification.Name(rawValue: "rankCardClicked")
    }
    
    enum Genre {
        static let dictionary: [Int: String] = [28: "액션", 12: "어드벤처", 16: "애니메이션", 35: "코미디", 80: "범죄", 99: "다큐멘터리", 
                                                18: "드라마", 10751: "가족", 14: "판타지", 36: "역사", 27: "공포", 10402: "음악", 9648: "미스터리", 
                                                10749: "로맨스", 878: "SF", 10770: "TV 영화", 53: "스릴러", 10752: "전쟁", 37: "서부"]
    }
}
