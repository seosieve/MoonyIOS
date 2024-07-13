//
//  BaseTableView.swift
//  MoviePack
//
//  Created by 서충원 on 6/30/24.
//

import UIKit

class BaseTableView: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        
    }
    
    func configureSubviews() {
        
    }
    
    func configureConstraints() {
        
    }
}
