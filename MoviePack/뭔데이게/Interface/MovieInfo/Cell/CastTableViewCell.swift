//
//  CastTableViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import UIKit
import Then
import SnapKit

final class CastTableViewCell: BaseTableViewCell {
    
    let castImageView = UIImageView().then {
        $0.backgroundColor = Colors.blackContent
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    let actorNameLabel = UILabel().then {
        $0.textColor = Colors.blackAccent
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    let castNameLabel = UILabel().then {
        $0.textColor = Colors.blackContent
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 2
    }
    
    override func configureView() {
        self.selectionStyle = .none
        backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        contentView.addSubview(castImageView)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(castNameLabel)
    }
    
    override func configureConstraints() {
        castImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(70)
        }
        
        actorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(castImageView).inset(2)
            make.leading.equalTo(castImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        castNameLabel.snp.makeConstraints { make in
            make.top.equalTo(actorNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(castImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configureCell(person: Person) {
        if person.profilePath != nil {
            ///Profile Image Exists
            let url = URL(string: person.imageUrl)
            castImageView.kf.setImage(with: url)
            castImageView.contentMode = .scaleAspectFill
        } else {
            ///Profile Image Not Exists
            let config = UIImage.SymbolConfiguration(pointSize: 34)
            let image = UIImage(systemName: "person.fill", withConfiguration: config)
            castImageView.image = image
            castImageView.tintColor = Colors.blackDescription.withAlphaComponent(0.2)
            castImageView.contentMode = .center
        }
        actorNameLabel.text = person.originalName
        let characterName = person.character ?? ""
        castNameLabel.text = "\(characterName) 역"
    }
}
