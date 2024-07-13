//
//  NSObjectProtocol + Extenstion.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit

extension NSObjectProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
