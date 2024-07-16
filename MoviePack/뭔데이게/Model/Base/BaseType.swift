//
//  BaseType.swift
//  MoviePack
//
//  Created by 서충원 on 7/17/24.
//

import Foundation

protocol BaseType: Decodable {
    var id: Int { get }
    var imageUrl: String { get }
}
