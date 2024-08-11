//
//  MoviePreviewView.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import UIKit

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
        $0.register(PreviewCollectionViewCell.self, forCellWithReuseIdentifier: PreviewCollectionViewCell.identifier)
        $0.isPagingEnabled = true
        $0.decelerationRate = .fast
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
    }
    
    override func configureConstraints() {
        previewScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.equalTo(1500)
        }
        
        previewCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44 + MoviePreviewView.safeArea.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(220)
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.setCustomBackButton()
    }
}
