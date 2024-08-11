//
//  GenreCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 8/10/24.
//

import UIKit

class GenreCollectionViewCell: BaseCollectionViewCell {
    
    private let genreBackgroundView = UIView().then {
        $0.backgroundColor = Colors.blackInterface
        $0.layer.borderColor = Colors.blackDescription.cgColor
        $0.layer.cornerRadius = 30
    }
    
    private let genreImageView = UIImageView().then {
        $0.tintColor = Colors.blackContent
        $0.contentMode = .scaleAspectFill
    }
    
    private let genreName = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textColor = Colors.blackContent
        $0.textAlignment = .center
    }
    
    override func configureView() {
        contentView.backgroundColor = .clear
    }
    
    override func configureSubViews() {
        contentView.addSubview(genreBackgroundView)
        genreBackgroundView.addSubview(genreImageView)
        contentView.addSubview(genreName)
    }
    
    override func configureConstraints() {
        genreBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview()
            make.size.equalTo(60)
        }
        
        genreImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(14)
        }
        
        genreName.snp.makeConstraints { make in
            make.top.equalTo(genreBackgroundView.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureCell(_ genre: Names.Genre) {
        let genreImageName = String(describing: genre)
        let genreImage = UIImage(named: genreImageName)
        genreImageView.image = genreImage
        genreName.text = genre.description
        ///For Reuse Issue
        self.isSelected ? selectAction() : deselectAction()
    }
}

//MARK: - Animations
extension GenreCollectionViewCell {
    func selectAnimation() {
        genreBackgroundView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 1.3, delay: 0.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveLinear) {
            self.genreBackgroundView.transform = CGAffineTransform.identity
            self.selectAction()
        }
    }
    
    func selectAction() {
        genreBackgroundView.backgroundColor = Colors.blackContent
        genreBackgroundView.layer.borderWidth = 2
        genreImageView.tintColor = Colors.blackAccent
        genreName.textColor = Colors.blackDescription
    }
    
    func deselectAction() {
        genreBackgroundView.backgroundColor = Colors.blackInterface
        genreBackgroundView.layer.borderWidth = 0
        genreImageView.tintColor = Colors.blackContent
        genreName.textColor = Colors.blackContent
    }
}
