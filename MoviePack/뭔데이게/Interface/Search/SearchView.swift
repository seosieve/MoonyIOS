//
//  SearchView.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

final class SearchView: BaseView {
    
    private let searchSort = UserDefaultsManager.shared.searchSort
    
    private lazy var twoColum = UIAction(title: "두 줄 정렬", state: .off, handler: updateActionStates)
                                  
    private lazy var threeColum = UIAction(title: "세 줄 정렬", state: .off, handler: updateActionStates)
    
    private lazy var fourColum = UIAction(title: "네 줄 정렬", state: .off, handler: updateActionStates)
    
    private lazy var updateActionStates: (UIAction) -> Void = { action in
        ///ReGenerate Menu
        var sortArr = [self.twoColum, self.threeColum, self.fourColum]
        sortArr.forEach { $0.state = ($0 == action) ? .on : .off }
        self.sortButtonItem.menu = UIMenu(options: .displayInline, children: sortArr)
        ///Selected Index
        guard let index = sortArr.firstIndex(where: { $0.title == action.title }) else { return }
        let sortName = sortArr[index]
        self.sortLayout(column: index+2)
        ///Set UserDefaults
        UserDefaultsManager.shared.searchSort = index+2
    }
    
    private func sortLayout(column: Int) {
        searchCollectionView.setCollectionViewLayout(searchLayout(column: column), animated: true)
    }
    
    lazy var sortButtonItem = UIBarButtonItem().then {
        let config = UIImage.SymbolConfiguration(weight: .black)
        $0.image = Images.ellipsis?.withConfiguration(config)
        $0.style = .plain
        $0.menu = UIMenu(options: .displayInline, children: [twoColum, threeColum, fourColum])
    }
    
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
    
    private let searchDivider = UIView().then {
        $0.backgroundColor = Colors.blackInterface
    }
    
    private func searchLayout(column: Int) -> UICollectionViewLayout {
        ///Set Item Ratio
        let itemAspectRatio: CGFloat = 4.0 / 3.0
        ///Set Column
        let column = CGFloat(column)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / column), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1 / column * itemAspectRatio))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    lazy var searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchLayout(column: searchSort)).then {
        $0.backgroundColor = .clear
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
    }
    
    var emptyLabel = UILabel().then {
        $0.text = Names.PlaceHolder.emptyResult
        $0.withLineSpacing(8)
        $0.textColor = Colors.blackContent
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        self.addSubview(searchBackgroundView)
        searchBackgroundView.addSubview(magnifierImageView)
        searchBackgroundView.addSubview(searchTextField)
        self.addSubview(wordCollectionView)
        self.addSubview(searchDivider)
        self.addSubview(searchCollectionView)
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
            make.top.equalTo(searchBackgroundView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(36)
        }
        
        searchDivider.snp.makeConstraints { make in
            make.top.equalTo(wordCollectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchDivider.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30)
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.rightBarButtonItem = sortButtonItem
        vc.navigationItem.title = "SEARCCH"
    }
    
    func configureInitialMenu() {
        let sortArr = [twoColum, threeColum, fourColum]
        sortArr[searchSort - 2].state = .on
        sortButtonItem.menu = UIMenu(options: .displayInline, children: sortArr)
    }
}
