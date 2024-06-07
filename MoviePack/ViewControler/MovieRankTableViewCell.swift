//
//  MovieRankTableViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/6/24.
//

import UIKit
import SnapKit

class MovieRankTableViewCell: UITableViewCell {

    let movieTitleLabel = {
        let label = UILabel()
        label.text = "영화제목"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionAnimation()
    }
    
    func configureUI() {
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
