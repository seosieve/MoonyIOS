//
//  WordCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 8/9/24.
//

import UIKit

class WordCollectionViewCell: BaseCollectionViewCell {
    
    private let wordBackgroundView = UIView().then {
        $0.layer.borderColor = Colors.blackInterface.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 18
    }
    
    private let searchedWordLabel = UILabel().then {
        $0.textColor = Colors.blackAccent
        $0.textAlignment = .center
    }
    
    override func configureView() {
        contentView.backgroundColor = .clear
    }
    
    override func configureSubViews() {
        contentView.addSubview(wordBackgroundView)
        wordBackgroundView.addSubview(searchedWordLabel)
    }
    
    override func configureConstraints() {
        wordBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchedWordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(6)
        }
    }
    
    func configureCell(word: String) {
        searchedWordLabel.text = word
    }
}

