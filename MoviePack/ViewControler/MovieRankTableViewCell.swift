//
//  MovieRankTableViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/6/24.
//

import UIKit
import SnapKit

class MovieRankTableViewCell: UITableViewCell {

    let rankLabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "1"
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.text = "영화제목"
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray6
        label.text = "2024-06-01"
        label.textAlignment = .right
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
        backgroundColor = .clear
    }
    
    func configureSubviews() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureConstraints() {
        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(dateLabel.snp.leading).offset(-10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureCell(movie: Movie) {
        rankLabel.text = movie.rank
        titleLabel.text = movie.movieNm
        dateLabel.text = movie.openDt
    }
}
