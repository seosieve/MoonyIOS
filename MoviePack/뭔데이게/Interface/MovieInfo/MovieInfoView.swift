//
//  MovieInfoView.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import UIKit
import Then
import SnapKit

final class MovieInfoView: BaseView {
    
    private var spread = false
    
    private lazy var movieInfoScrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.delegate = self
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = Colors.blackBackground
    }
    
    private let posterLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: MovieInfoView.screenSize.width, height: 360)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
    }
    
    lazy var posterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: posterLayout).then {
        $0.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
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
    
    private let gradeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blueContent
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont(name: "BlackHanSans-Regular", size: 26)
        $0.textColor = .white
    }
    
    private let engTitleLabel = UILabel().then {
        $0.font = UIFont(name: "StretchProRegular", size: 16)
        $0.textColor = Colors.blackDescription
        $0.numberOfLines = 2
    }
    
    private let firstGenreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = Colors.blueContent
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0
        $0.layer.borderColor = Colors.blueContent.cgColor
        $0.layer.masksToBounds = true
    }
    
    private let secondGenreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = Colors.blueContent
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0
        $0.layer.borderColor = Colors.blueContent.cgColor
        $0.layer.masksToBounds = true
    }
    
    private let thirdGenreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = Colors.blueContent
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0
        $0.layer.borderColor = Colors.blueContent.cgColor
        $0.layer.masksToBounds = true
    }
    
    let previewImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 22
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = Colors.blackDescription.cgColor
        $0.clipsToBounds = true
    }
    
    private let previewVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let previewButton = UIButton().then {
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
    
    let overviewTitleLabel = UILabel().then {
        $0.text = "Overview"
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blackAccent
    }
    
    private let overviewLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = Colors.blackDescription
        $0.numberOfLines = 2
    }
    
    private let spreadUpImage = UIImage(systemName: "chevron.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold))

    private let spreadDownImage = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold))
    
    private lazy var spreadButton = UIButton().then {
        $0.setImage(spreadDownImage, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = Colors.blackDescription.withAlphaComponent(0.1)
        $0.layer.cornerRadius = 22
        $0.addTarget(self, action: #selector(spreadButtonClicked), for: .touchUpInside)
    }
    
    private let castTitleLabel = UILabel().then {
        $0.text = "Cast"
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blackAccent
    }
    
    lazy var castTableView = UITableView().then {
        $0.rowHeight = 120
        $0.isScrollEnabled = false
        $0.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
    }
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        self.addSubview(movieInfoScrollView)
        movieInfoScrollView.addSubview(contentView)
        contentView.addSubview(posterCollectionView)
        contentView.addSubview(gardeTitleLabel)
        contentView.addSubview(gradeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(engTitleLabel)
        contentView.addSubview(firstGenreLabel)
        contentView.addSubview(secondGenreLabel)
        contentView.addSubview(thirdGenreLabel)
        contentView.addSubview(previewImageView)
        previewImageView.addSubview(previewVisualEffectView)
        contentView.addSubview(previewButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(saveButton)
        contentView.addSubview(overviewTitleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(spreadButton)
        contentView.addSubview(castTitleLabel)
        contentView.addSubview(castTableView)
    }
    
    override func configureConstraints() {
        movieInfoScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(360)
        }
        
        gardeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterCollectionView.snp.bottom).inset(90)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        gradeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(gardeTitleLabel)
            make.leading.equalTo(gardeTitleLabel.snp.trailing).offset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(gardeTitleLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        engTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(22)
        }
        
        firstGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(engTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(22)
            make.width.equalTo(firstGenreLabel.intrinsicContentSize.width + 20)
            make.height.equalTo(24)
        }
        
        secondGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(engTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(firstGenreLabel.snp.trailing).offset(8)
            make.width.equalTo(secondGenreLabel.intrinsicContentSize.width + 20)
            make.height.equalTo(24)
        }
        
        thirdGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(engTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(secondGenreLabel.snp.trailing).offset(8)
            make.width.equalTo(thirdGenreLabel.intrinsicContentSize.width + 20)
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
            make.edges.equalTo(previewImageView)
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
        
        spreadButton.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(44)
        }
        
        castTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(spreadButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
        }
        
        castTableView.snp.makeConstraints { make in
            make.top.equalTo(castTitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.equalToSuperview().offset(-120)
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.setCustomBackButton()
    }
    
    @objc func spreadButtonClicked() {
        UIView.animate(withDuration: 0.3) {
            let image = self.spread ? self.spreadDownImage : self.spreadUpImage
            let line = self.spread ? 2 : 0
            
            self.spreadButton.setImage(image, for: .normal)
            self.overviewLabel.numberOfLines = line
            self.layoutIfNeeded()
            self.invalidateIntrinsicContentSize()
            self.spread.toggle()
        }
    }
    
    func configureMovieInfo(_ movie: Movie?) {
        guard let movie, let genreID = movie.genreID else { return }
        
        let url = URL(string: movie.imageUrl)
        previewImageView.kf.setImage(with: url)
        let labels = [firstGenreLabel, secondGenreLabel, thirdGenreLabel]
        let genres = genreID.compactMap{$0}
        for (index, genreID) in genres.prefix(3).enumerated() {
            let genreName = Names.Genre.dictionary[genreID]
            labels[index].text = genreName
            labels[index].layer.borderWidth = 1
            labels[index].snp.updateConstraints { make in
                make.width.equalTo(labels[index].intrinsicContentSize.width + 20)
            }
        }
        engTitleLabel.text = movie.title
        gradeLabel.text = String(format: "%.1f", movie.grade ?? 0.0)
    }
    
    func configureOverview(_ overview: String) {
        overviewLabel.text = overview
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
