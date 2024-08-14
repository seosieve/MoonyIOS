//
//  WordCollectionViewCell.swift
//  Moony
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
        $0.textColor = Colors.blackDescription
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .center
    }
    
    let deleteButton = UIButton().then {
        let config = UIImage.SymbolConfiguration(weight: .black)
        $0.setImage(Images.xmark?.withConfiguration(config), for: .normal)
        $0.backgroundColor = Colors.blackInterface
        $0.tintColor = Colors.blackContent
        $0.layer.cornerRadius = 12
    }
    
    override func configureView() {
        contentView.backgroundColor = .clear
    }
    
    override func configureSubViews() {
        contentView.addSubview(wordBackgroundView)
        wordBackgroundView.addSubview(searchedWordLabel)
        wordBackgroundView.addSubview(deleteButton)
    }
    
    override func configureConstraints() {
        wordBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchedWordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(deleteButton.snp.leading).offset(-6)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(6)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    
    func configureCell(word: String) {
        searchedWordLabel.text = word
    }
}

