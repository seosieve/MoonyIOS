//
//  RankCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit
import Then
import SnapKit

class RankCollectionViewCell: BaseCollectionViewCell {
    
    private let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "베테랑")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let fullScreenVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private let topCustomView = UIView().then {
        $0.backgroundColor = Colors.blackBackground
        $0.layer.cornerRadius = 10
    }
    
    private let leadingCustomView = UIView().then {
        $0.backgroundColor = Colors.blackBackground
        $0.layer.cornerRadius = 10
    }
    
    private let posterImageView = UIImageView().then {
        $0.image = UIImage(named: "베테랑")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let poundKeyLabel = UILabel().then {
        $0.text = "#"
        $0.font = UIFont(name: "StretchProRegular", size: 25)
        $0.textColor = Colors.blackAccent
    }
    
    private let rankLabel = UILabel().then {
        $0.text = "1"
        $0.font = UIFont(name: "StretchProRegular", size: 30)
        $0.textColor = .white
    }
    
    private let changeRankLabel = UILabel().then {
        $0.text = "⬆︎4"
        $0.font = UIFont(name: "StretchProRegular", size: 15)
        $0.textColor = Colors.blackDescription
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "인사이드 아웃 2"
        $0.font = UIFont(name: "BlackHanSans-Regular", size: 20)
        $0.textColor = .white
    }
    
    private let engTitleLabel = UILabel().then {
        $0.text = "Inside Out 2"
        $0.font = UIFont(name: "StretchProRegular", size: 12)
        $0.textColor = Colors.blackDescription
    }
    
    let gradeLabel = UILabel().then {
        $0.text = "★★★☆☆"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = Colors.blueDescription
    }
    
    let totalViewerLabel = UILabel().then {
        $0.text = "540,221 명"
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = Colors.blackAccent
    }
    
    let todayViewerLabel = UILabel().then {
        $0.text = "30,931 명"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = Colors.blackDescription
    }
    
    let barcodeImageView = UIImageView().then {
        $0.image = UIImage(named: "barcode")
        $0.contentMode = .scaleAspectFill
        $0.tintColor = Colors.blackContent
    }
    
    override func configureView() {
        contentView.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(fullScreenVisualEffectView)
        contentView.addSubview(topCustomView)
        contentView.addSubview(leadingCustomView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(poundKeyLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(changeRankLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(engTitleLabel)
        contentView.addSubview(gradeLabel)
        contentView.addSubview(totalViewerLabel)
        contentView.addSubview(todayViewerLabel)
        contentView.addSubview(barcodeImageView)
    }
    
    override func configureConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        fullScreenVisualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topCustomView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(60)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        
        leadingCustomView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(110)
            make.width.equalTo(20)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(70)
            make.height.equalTo(300)
        }
        
        poundKeyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(27)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalTo(poundKeyLabel.snp.trailing).offset(1)
        }
        
        changeRankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(rankLabel).offset(5)
            make.trailing.equalToSuperview().inset(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        engTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        gradeLabel.snp.makeConstraints { make in
            make.top.equalTo(engTitleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        totalViewerLabel.snp.makeConstraints { make in
            make.top.equalTo(gradeLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        todayViewerLabel.snp.makeConstraints { make in
            make.top.equalTo(totalViewerLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        barcodeImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(15)
            make.width.equalTo(60)
            make.height.equalTo(90)
        }
    }
}
