//
//  Optional + Extension.swift
//  Moony
//
//  Created by 서충원 on 8/10/24.
//

import Foundation

//Make Optional Comparable function
extension Optional where Wrapped: Comparable {
    
    static func < (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?):
            return l < r
        case (nil, _):
            return true
        case (_, nil):
            return false
        }
    }

    static func > (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?):
            return l > r
        case (nil, _):
            return false
        case (_, nil):
            return true
        }
    }
}
