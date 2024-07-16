//
//  Trend.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import Foundation

struct TrendResult<T: BaseType>: Decodable {
    let results: [T]
}
