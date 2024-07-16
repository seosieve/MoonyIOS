//
//  RankCollectionViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

final class RankCollectionViewCell: BaseCollectionViewCell {
    
    private let backgroundImageView = UIImageView().then {
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
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.blackDescription.cgColor
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
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private let engTitleLabel = UILabel().then {
        $0.text = "Inside Out 2"
        $0.font = UIFont(name: "StretchProRegular", size: 12)
        $0.textColor = Colors.blackDescription
        $0.textAlignment = .center
        $0.numberOfLines = 2
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
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = Colors.blackDescription
    }
    
    let barcodeImageView = UIImageView().then {
        $0.image = UIImage(named: "barcode")
        $0.contentMode = .scaleAspectFill
        $0.tintColor = Colors.blackDescription.withAlphaComponent(0.2)
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
            make.horizontalEdges.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        engTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
        }
        
        gradeLabel.snp.makeConstraints { make in
            make.top.equalTo(engTitleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        totalViewerLabel.snp.makeConstraints { make in
            make.top.equalTo(gradeLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        todayViewerLabel.snp.makeConstraints { make in
            make.top.equalTo(totalViewerLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        barcodeImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(15)
            make.width.equalTo(60)
            make.height.equalTo(90)
        }
    }
    
    func configureCell(_ kobisRank: KobisRank) {
        rankLabel.text = kobisRank.rank

        switch kobisRank.rankInten {
        case "0":
            changeRankLabel.textColor = Colors.blackDescription
            changeRankLabel.text = "◼︎"
        case let value where value.hasPrefix("-"):
            changeRankLabel.textColor = Colors.blueDescription
            changeRankLabel.text = "⬇︎\(value.dropFirst())"
        default:
            changeRankLabel.textColor = Colors.redContent
            changeRankLabel.text = "⬆︎\(kobisRank.rankInten)"
        }
        
        titleLabel.text = kobisRank.movieNm
        
        totalViewerLabel.text = Int(kobisRank.audiAcc)!.formatted() + " 명"
        todayViewerLabel.text = Int(kobisRank.audiCnt)!.formatted() + " 명"
    }
    
    func configureCell(_ searchMovie: Movie?) {
        guard let searchMovie else { return }
        
        let url = URL(string: searchMovie.posterUrl)
        backgroundImageView.kf.setImage(with: url)
        posterImageView.kf.setImage(with: url)
        engTitleLabel.text = searchMovie.title
        
        let grade = Int(round(searchMovie.grade ?? 0.0)) / 2
        let fullStars = String(repeating: "★", count: grade)
        let emptyStars = String(repeating: "☆", count: 5 - grade)
        gradeLabel.text = fullStars + emptyStars
    }
}

