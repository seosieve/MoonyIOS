//
//  BaseType.swift
//  Moony
//
//  Created by 서충원 on 7/17/24.
//

import Foundation

protocol BaseType: Decodable {
    var id: Int { get }
    var name: String? { get }
    var originalName: String? { get }
    var imageUrl: String { get }
}
