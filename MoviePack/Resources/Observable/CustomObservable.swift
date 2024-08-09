//
//  CustomObservable.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import Foundation

class CustomObservable<T> {
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet { closure?(value) }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}

