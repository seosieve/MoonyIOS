//
//  SearchCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import UIKit

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    private let searchImageView = UIImageView().then {
        $0.backgroundColor = Colors.blackInterface
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let dimView = UIView().then {
        $0.backgroundColor = Colors.blackBackground.withAlphaComponent(0.4)
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .heavy)
        $0.textAlignment = .center
        $0.textColor = Colors.blackAccent
        $0.numberOfLines = 2
    }
    
    override func configureSubViews() {
        contentView.addSubview(searchImageView)
        contentView.addSubview(dimView)
        contentView.addSubview(titleLabel)
    }
    
    override func configureConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.edges.horizontalEdges.equalToSuperview()
        }
        
        dimView.snp.makeConstraints { make in
            make.edges.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureCell(result: Movie) {
        titleLabel.text = result.name
        let url = URL(string: result.imageUrl)
        searchImageView.kf.setImage(with: url)
    }
}

