//
//  Video.swift
//  Moony
//
//  Created by 서충원 on 7/15/24.
//

import Foundation

struct VideoResult: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let key: String
}
