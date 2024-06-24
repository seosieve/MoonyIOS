//
//  BaseView.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() { }
    func configureSubviews() { }
    func configureConstraints() { }
}
