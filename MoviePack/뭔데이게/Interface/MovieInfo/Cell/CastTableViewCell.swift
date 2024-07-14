//
//  CastTableViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import UIKit
import Then
import SnapKit

class CastTableViewCell: UITableViewCell {
    
    let castImageView = UIImageView().then {
        $0.backgroundColor = Colors.blackContent
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    let actorNameLabel = UILabel().then {
        $0.textColor = Colors.blackAccent
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.text = "Lee Jung-jae"
    }
    
    let castNameLabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Seong Gi-hun / \"No.073\""
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionAnimation()
    }
    
    func setViews() {
        backgroundColor = Colors.blackBackground
    }
    
    func configureSubviews() {
        contentView.addSubview(castImageView)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(castNameLabel)
    }
    
    func configureConstraints() {
        castImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(70)
        }
        
        actorNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(castImageView.snp.trailing).offset(20)
            make.bottom.equalTo(contentView.snp.centerY).offset(-8)
        }
        
        castNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(castImageView.snp.trailing).offset(20)
            make.top.equalTo(contentView.snp.centerY).offset(4)
        }
    }
    
    func configureCell(credits: Credits) {
        let url = URL(string: credits.profileUrl)
        castImageView.kf.setImage(with: url)
        actorNameLabel.text = credits.name
        castNameLabel.text = "\(credits.original_name) / \"\(credits.character)\""
    }
}
