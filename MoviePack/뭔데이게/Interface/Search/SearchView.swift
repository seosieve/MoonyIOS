//
//  SearchView.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

class SearchView: BaseView {
    
//    lazy var searchBar = {
//        let searchBar = UISearchBar()
//        searchBar.placeholder = "영화 제목을 검색해보세요."
//        searchBar.barTintColor = .black
//        searchBar.searchTextField.backgroundColor = .darkGray
//        searchBar.searchTextField.tintColor = .white
//        searchBar.searchTextField.textColor = .white
//        searchBar.setSearchTextFieldItemColor(to: .systemGray2)
//        return searchBar
//    }()
    
    lazy var searchBar = UISearchBar().then {
        $0.placeholder = "영화 제목을 검색해보세요."
        $0.barTintColor = .black
        $0.searchTextField.backgroundColor = .darkGray
        $0.searchTextField.tintColor = .white
        $0.searchTextField.textColor = .white
        $0.setSearchTextFieldItemColor(to: .systemGray2)
    }
    
    let flowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let screenWidth = SearchView.screenSize.width
        let inset = layout.sectionInset.left + layout.sectionInset.right
        let spacing = layout.minimumInteritemSpacing
        let width = (screenWidth - inset - spacing * 2) / 3
        let height = width + 40
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }()
    
    lazy var searchCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = Colors.blackBackground
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        return collectionView
    }()
    
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
        self.hideKeyboardWhenTappedAround()
    }
    
    override func configureSubViews() {
        self.addSubview(searchBar)
        self.addSubview(searchCollectionView)
        self.addSubview(emptyLabel)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
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
