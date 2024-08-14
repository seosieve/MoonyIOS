//
//  ViewModelType.swift
//  Moony
//
//  Created by 서충원 on 8/12/24.
//

import Foundation

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
