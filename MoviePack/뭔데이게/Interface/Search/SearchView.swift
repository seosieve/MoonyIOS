//
//  SearchView.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

final class SearchView: BaseView {
    
    private let searchBackgroundView = UIView().then {
        $0.backgroundColor = Colors.blackInterface
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
    }
    
    private let magnifierImageView = UIImageView().then {
        $0.image = Images.magnifier
        $0.tintColor = Colors.blackDescription
        $0.contentMode = .scaleAspectFill
    }
    
    let searchTextField = UITextField().then {
        $0.placeholder = Names.PlaceHolder.search
        $0.setPlaceholderColor(color: Colors.blackDescription.withAlphaComponent(0.5))
    }
    
    private let wordLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    lazy var wordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: wordLayout).then {
        $0.register(WordCollectionViewCell.self, forCellWithReuseIdentifier: WordCollectionViewCell.description())
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    
    private lazy var movieLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: movieLayout).then {
        $0.backgroundColor = .clear
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
    }
    
    var emptyLabel = {
        let label = UILabel()
        label.text = "검색 결과가 없어요\n검색어를 입력해주세요"
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        self.addSubview(searchBackgroundView)
        searchBackgroundView.addSubview(magnifierImageView)
        searchBackgroundView.addSubview(searchTextField)
        self.addSubview(wordCollectionView)
        self.addSubview(movieCollectionView)
        self.addSubview(emptyLabel)
    }
    
    override func configureConstraints() {
        searchBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }
        
        magnifierImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(magnifierImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        
        wordCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBackgroundView.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(36)
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(wordCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureView(isEmpty: Bool) {
        emptyLabel.isHidden = isEmpty
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.title = "SEARCCH"
    }
}
