//
//  SearchDetailView.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

class SearchDetailView: BaseView {
    
    let similarLabel = {
        let label = UILabel()
        label.text = "비슷한 영화"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        return label
    }()
    
    static func flowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 100, height: 150)
        return layout
    }
    
    let posterFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: 150, height: 200)
        return layout
    }()
    
    var similarCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
        collectionView.backgroundColor = .black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        return collectionView
    }()
    
    let recommendLabel = {
        let label = UILabel()
        label.text = "추천 영화"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        return label
    }()
    
    var recommendCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
        collectionView.backgroundColor = .black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        return collectionView
    }()
    
    let posterLabel = {
        let label = UILabel()
        label.text = "포스터"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var posterCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: posterFlowLayout)
        collectionView.backgroundColor = .black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func configureSubviews() {
        self.addSubview(similarLabel)
        self.addSubview(similarCollectionView)
        self.addSubview(recommendLabel)
        self.addSubview(recommendCollectionView)
        self.addSubview(posterLabel)
        self.addSubview(posterCollectionView)
    }
    
    override func configureConstraints() {
        similarLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(similarLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(150)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.top.equalTo(similarCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(150)
        }
        
        posterLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(posterLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}
