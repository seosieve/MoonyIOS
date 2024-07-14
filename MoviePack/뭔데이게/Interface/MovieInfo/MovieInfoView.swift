//
//  MovieInfoView.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import UIKit
import Then
import SnapKit

class MovieInfoView: BaseView {
    
    private lazy var movieInfoScrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.delegate = self
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = Colors.blackBackground
    }
    
    private let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "베테랑")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private lazy var gradientView = UIView().then {
        $0.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 300))
        gradientLayer.colors = [UIColor.clear.cgColor, Colors.blackBackground.cgColor]
        $0.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private let gardeTitleLabel = UILabel().then {
        $0.text = "평점"
        $0.font = .systemFont(ofSize: 14, weight: .heavy)
        $0.textColor = .white
        $0.backgroundColor = Colors.blueContent
        $0.textAlignment = .center
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    private let gardeLabel = UILabel().then {
        $0.text = "4.2"
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blueContent
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "인사이드 아웃 2"
        $0.font = UIFont(name: "BlackHanSans-Regular", size: 26)
        $0.textColor = .white
    }
    
    private let engTitleLabel = UILabel().then {
        $0.text = "Inside Out 2"
        $0.font = UIFont(name: "StretchProRegular", size: 16)
        $0.textColor = Colors.blackDescription
    }
    
    private let firstGenreLabel = UILabel().then {
        $0.text = "SF"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = Colors.blueContent
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.blueContent.cgColor
        $0.layer.masksToBounds = true
    }
    
    private let secondGenreLabel = UILabel().then {
        $0.text = "공포"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = Colors.blueContent
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.blueContent.cgColor
        $0.layer.masksToBounds = true
    }
    
    private let thirdGenreLabel = UILabel().then {
        $0.text = "액션"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = Colors.blueContent
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.blueContent.cgColor
        $0.layer.masksToBounds = true
    }
    
    private let previewImageView = UIImageView().then {
        $0.image = UIImage(named: "베테랑")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 22
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = Colors.blackDescription.cgColor
        $0.clipsToBounds = true
    }
    
    private let previewVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private let previewButton = UIButton().then {
        $0.setTitle("PREVIEW NOW", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.setTitleColor(Colors.blackAccent, for: .normal)
    }
    
    private let shareButton = UIButton().then {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let image = UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = Colors.blackDescription.withAlphaComponent(0.2)
        $0.layer.cornerRadius = 22
    }
    
    private let saveButton = UIButton().then {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let image = UIImage(systemName: "bookmark", withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = Colors.blackDescription.withAlphaComponent(0.2)
        $0.layer.cornerRadius = 22
    }
    
    private let overviewTitleLabel = UILabel().then {
        $0.text = "Overview"
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blackAccent
    }
    
    private let overviewLabel = UILabel().then {
        $0.text = "Overviewdjkwajkd wajkdhkwadhwhdwajkdhwahkdhkjwakdjh wakjhdw adkwadhjk wahwalkdkwa dwalhdlwajd kwaj ddwahdjwkd wkajdh wkajdhwa jkd wajkdhjwak dhwakjd wakjdh awkjhd jwkad kajdh kjwadhwajkdhwakjd wakdj wakd wkad"
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = Colors.blackDescription
        $0.numberOfLines = 0
    }
    
    private let castTitleLabel = UILabel().then {
        $0.text = "Cast"
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blackAccent
    }
    
    lazy var castTableView = UITableView().then {
        $0.rowHeight = 120
        $0.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
    }
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        self.addSubview(movieInfoScrollView)
        movieInfoScrollView.addSubview(contentView)
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(gardeTitleLabel)
        contentView.addSubview(gardeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(engTitleLabel)
        contentView.addSubview(firstGenreLabel)
        contentView.addSubview(secondGenreLabel)
        contentView.addSubview(thirdGenreLabel)
        contentView.addSubview(previewImageView)
        previewImageView.addSubview(previewVisualEffectView)
        previewImageView.addSubview(previewButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(saveButton)
        contentView.addSubview(overviewTitleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(castTitleLabel)
        contentView.addSubview(castTableView)
    }
    
    override func configureConstraints() {
        movieInfoScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.equalTo(3000)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(360)
        }
        
        gradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(backgroundImageView)
            make.height.equalTo(300)
        }
        
        gardeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(gradientView.snp.bottom).inset(90)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        gardeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(gardeTitleLabel)
            make.leading.equalTo(gardeTitleLabel.snp.trailing).offset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(gardeTitleLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().inset(20)
        }
        
        engTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(22)
        }
        
        firstGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(engTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(22)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        secondGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(engTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(firstGenreLabel.snp.trailing).offset(8)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        thirdGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(engTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(secondGenreLabel.snp.trailing).offset(8)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        previewImageView.snp.makeConstraints { make in
            make.top.equalTo(firstGenreLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(160)
            make.height.equalTo(44)
        }
        
        previewVisualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        previewButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(previewImageView)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(shareButton)
            make.trailing.equalTo(shareButton.snp.leading).offset(-16)
            make.size.equalTo(44)
        }
        
        overviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        castTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
        }
        
        castTableView.snp.makeConstraints { make in
            make.top.equalTo(castTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.setCustomBackButton()
    }
}

//MARK: - UIScrollViewDelegate
extension MovieInfoView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}
