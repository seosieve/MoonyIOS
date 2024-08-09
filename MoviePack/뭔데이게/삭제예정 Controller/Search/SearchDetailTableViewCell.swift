//
//  SearchDetailTableViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/30/24.
//

import UIKit
import Toast

class SearchDetailTableViewCell: BaseTableViewCell {
    
    weak var delegate: TableViewCellDelegate?
    
    var type: CollectionViewType = .similar
    
    var resultsArr: [Movie] = [Movie]() {
        didSet { self.searchDetailCollectionView.reloadData() }
    }
    
    let titleLabel = {
        let label = UILabel()
        label.text = "비슷한 영화"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        return label
    }()
    
    static func flowLayout(width: Int, height: Int) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }
    
    lazy var searchDetailCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .black
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        return collectionView
    }()
    
    override func configureView() {
        contentView.backgroundColor = .black
    }
    
    override func configureSubViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(searchDetailCollectionView)
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        searchDetailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.equalTo(180)
        }
    }
}

//MARK: - SearchDetailTableViewCell
extension SearchDetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        cell.configureCell(result: resultsArr[indexPath.row])
        
        return cell
    }
}

//MARK: - UICollectionViewDataSourcePrefetching
extension SearchDetailTableViewCell: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if type == .poster { return }
        
        for indexPath in indexPaths {
            if resultsArr.count - 1 == indexPath.item {
                contentView.makeToastActivity(.center)
                delegate?.configureResult(type: type) { resultsArr in
                    self.resultsArr += resultsArr
                    self.contentView.hideToastActivity()
                }
            }
        }
    }
}

protocol TableViewCellDelegate: AnyObject {
    func configureResult(type: CollectionViewType, completionHandler: @escaping ([Movie]) -> Void)
}
