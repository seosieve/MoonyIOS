//
//  UpcomingView.swift
//  MoviePack
//
//  Created by 서충원 on 8/10/24.
//

import UIKit

final class UpcomingView: BaseView {
    
    private lazy var dateOrder = UIAction(title: "날짜 순", state: .off, handler: updateActionStates)
    
    private lazy var expectationOrder = UIAction(title: "기대 순", state: .off, handler: updateActionStates)
    
    private lazy var updateActionStates: (UIAction) -> Void = { action in
        ///ReGenerate Menu
        var sortArr = [self.dateOrder, self.expectationOrder]
        sortArr.forEach { $0.state = ($0 == action) ? .on : .off }
        self.sortButtonItem.menu = UIMenu(options: .displayInline, children: sortArr)
    }
    
    lazy var sortButtonItem = UIBarButtonItem().then {
        let config = UIImage.SymbolConfiguration(weight: .black)
        $0.image = Images.ellipsis?.withConfiguration(config)
        $0.style = .plain
        $0.menu = UIMenu(options: .displayInline, children: [dateOrder, expectationOrder])
    }
    
    private let genreLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 60, height: 60)
    }
    
    lazy var genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: genreLayout).then {
        $0.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.description())
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let upcomingDivider = UIView().then {
        $0.backgroundColor = Colors.blackInterface
    }
    
    private var upcomingLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var upcomingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: upcomingLayout).then {
        $0.backgroundColor = .clear
        $0.contentInset = UIEdgeInsets(top: -14, left: 0, bottom: 40, right: 0)
    }
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        self.addSubview(genreCollectionView)
        self.addSubview(upcomingDivider)
        self.addSubview(upcomingCollectionView)
    }
    
    override func configureConstraints() {
        genreCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }
        
        upcomingDivider.snp.makeConstraints { make in
            make.top.equalTo(genreCollectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        upcomingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(upcomingDivider.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.rightBarButtonItem = sortButtonItem
        vc.navigationItem.title = "UPCOOMING"
    }
}
