//
//  MoviePreviewView.swift
//  Moony
//
//  Created by 서충원 on 7/15/24.
//

import UIKit
import ScrollingPageControl

final class MoviePreviewView: BaseView {
    
    private lazy var previewScrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = Colors.blackBackground
    }
    
    private let previewLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: MoviePreviewView.screenSize.width, height: 220)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
    }
    
    lazy var previewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: previewLayout).then {
        $0.register(PreviewCollectionViewCell.self, forCellWithReuseIdentifier: PreviewCollectionViewCell.description())
        $0.isPagingEnabled = true
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
    }
    
    private let pageControl = ScrollingPageControl().then {
        $0.pages = 4
        $0.centerDots = 1
        $0.maxDots = 3
    }
    
    let taglineLabel = UILabel().then {
        $0.font = Fonts.han(22)
        $0.textColor = Colors.blackDescription
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private let posterTitleLabel = UILabel().then {
        $0.text = "Posters"
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blackAccent
    }
    
    private let posterLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 145, height: 210)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
    }
    
    lazy var posterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: posterLayout).then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.description())
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let similarTitleLabel = UILabel().then {
        $0.text = "Similar Ones?"
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blackAccent
    }
    
    private let similarLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 145, height: 240)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
    }
    
    lazy var similarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: similarLayout).then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.description())
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        self.addSubview(previewScrollView)
        previewScrollView.addSubview(contentView)
        contentView.addSubview(previewCollectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(taglineLabel)
        contentView.addSubview(posterTitleLabel)
        contentView.addSubview(posterCollectionView)
        contentView.addSubview(similarTitleLabel)
        contentView.addSubview(similarCollectionView)
    }
    
    override func configureConstraints() {
        previewScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        previewCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(54 + MoviePreviewView.safeArea.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(220)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(previewCollectionView.snp.bottom).offset(10)
        }
        
        taglineLabel.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
        posterTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(taglineLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().inset(20)
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(posterTitleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(210)
        }
        
        similarTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterCollectionView.snp.bottom).offset(50)
            make.leading.equalToSuperview().inset(20)
        }
        
        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(similarTitleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(240)
            make.bottom.equalToSuperview().offset(-120)
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.setCustomBackButton()
        vc.navigationItem.title = "PREVIEW"
    }
}

//MARK: - UICollectionViewDelegate
extension MoviePreviewView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.selectedPage = Int(page)
    }
}
