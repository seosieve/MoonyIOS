//
//  Identifier.swift
//  MoviePack
//
//  Created by 서충원 on 6/6/24.
//

import UIKit

extension NSObjectProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
