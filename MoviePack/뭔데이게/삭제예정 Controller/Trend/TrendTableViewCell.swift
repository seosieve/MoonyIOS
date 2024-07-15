//
//  TrendTableViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import UIKit
import SnapKit

class TrendTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .heavy)
        label.textColor = Colors.blackAccent
        label.text = "영화이름"
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .systemGray2
        label.text = "12/20/2024"
        return label
    }()
    
    let shadowView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
        return view
    }()
    
    let containerView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.backgroundColor = Colors.blackContent
        return view
    }()
    
    let trendImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Movie")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let clipButton = {
        let button = UIButton()
        button.backgroundColor = .white
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let paperclip = UIImage(systemName: "paperclip", withConfiguration: config)
        button.setImage(paperclip, for: .normal)
        button.tintColor = .darkGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    let scoreContainerLabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.text = "평점"
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return label
    }()
    
    let scoreLabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.text = "3.3"
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return label
    }()
    
    let movieTitleLabel = {
        let label = UILabel()
        label.textColor = Colors.blackAccent
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Alice in Borderland"
        return label
    }()
    
    let characterLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Kento Yamazaki, Ryu Kenreia, Ben Zenton"
        return label
    }()
    
    let divider = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 1
        return view
    }()
    
    let detailLabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "자세히 보기"
        return label
    }()
    
    lazy var detailButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .light)
        let paperclip = UIImage(systemName: "chevron.right", withConfiguration: config)
        button.setImage(paperclip, for: .normal)
        button.tintColor = .systemGray2
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    override func configureView() {
        backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(shadowView)
        shadowView.addSubview(containerView)
        containerView.addSubview(trendImageView)
        containerView.addSubview(clipButton)
        containerView.addSubview(scoreContainerLabel)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(movieTitleLabel)
        containerView.addSubview(characterLabel)
        containerView.addSubview(divider)
        containerView.addSubview(detailLabel)
        containerView.addSubview(detailButton)
        
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(35)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(6)
        }
        
        shadowView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.horizontalEdges.bottom.equalToSuperview().inset(30)
            make.height.equalTo(shadowView.snp.width)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        trendImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(trendImageView.snp.width).multipliedBy(0.6)
        }
        
        clipButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(trendImageView).inset(14)
            make.size.equalTo(30)
        }
        
        scoreContainerLabel.snp.makeConstraints { make in
            make.leading.equalTo(trendImageView.snp.leading).inset(14)
            make.bottom.equalTo(trendImageView.snp.bottom).inset(14)
            make.width.equalTo(40)
            make.height.equalTo(28)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scoreContainerLabel)
            make.leading.equalTo(scoreContainerLabel.snp.trailing)
            make.width.equalTo(35)
            make.height.equalTo(28)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(trendImageView.snp.bottom).offset(14)
            make.leading.equalToSuperview().inset(18)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(6)
            make.leading.equalTo(movieTitleLabel)
            make.centerX.equalToSuperview()
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(characterLabel.snp.bottom).offset(20)
            make.leading.equalTo(movieTitleLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(divider)
            make.bottom.equalToSuperview().inset(14)
        }
        
        detailButton.snp.makeConstraints { make in
            make.trailing.equalTo(divider)
            make.centerY.equalTo(detailLabel)
            make.width.equalTo(50)
        }
    }
    
    func configureCell(trend: Trend) {
        titleLabel.text = trend.title
        dateLabel.text = trend.formattedDate
        scoreLabel.text = trend.formattedScore
        movieTitleLabel.text = trend.original_title
        let url = URL(string: trend.posterUrl)
        trendImageView.kf.setImage(with: url)
    }
}
