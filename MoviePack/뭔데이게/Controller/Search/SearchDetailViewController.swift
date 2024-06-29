//
//  SearchDetailViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit
import Toast

class SearchDetailViewController: BaseViewController {

    var customView = SearchDetailView()
    
    var resultsArr: [[Results]] = Array(repeating: [Results](), count: 3)
    
    override func loadView() {
        self.view = customView
    }
    
    override func configure() {
        customView.similarCollectionView.delegate = self
        customView.similarCollectionView.dataSource = self
        customView.recommendCollectionView.delegate = self
        customView.recommendCollectionView.dataSource = self
        customView.posterCollectionView.delegate = self
        customView.posterCollectionView.dataSource = self
        
        let group = DispatchGroup()
        
        group.enter()
        SearchResult.shared.searchRequest(router: .similar(id: 940721), type: SearchMovieResult.self) { searchMovieResult in
            guard let searchMovieResult else { return }
            self.resultsArr[0] = searchMovieResult.results
            group.leave()
        }
        
        group.enter()
        SearchResult.shared.searchRequest(router: .recommend(id: 940721), type: SearchMovieResult.self) { searchMovieResult in
            guard let searchMovieResult else { return }
            self.resultsArr[1] = searchMovieResult.results
            group.leave()
        }
        
        group.enter()
        SearchResult.shared.searchRequest(router: .poster(id: 940721), type: PosterResult.self) { posterResult in
            guard let posterResult else { return }
            self.resultsArr[2] = posterResult.backdrops
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.customView.similarCollectionView.reloadData()
            self.customView.recommendCollectionView.reloadData()
            self.customView.posterCollectionView.reloadData()
        }
    }
    
    func configureType(_ collectionView: UICollectionView) -> CollectionViewType {
        switch collectionView {
        case customView.similarCollectionView:
            return .similar
        case customView.recommendCollectionView:
            return .recommend
        default:
            return .poster
        }
    }
}

enum CollectionViewType: Int {
    case similar
    case recommend
    case poster
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = configureType(collectionView)
        return resultsArr[type.rawValue].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        cell.removeGradient()
        let type = configureType(collectionView)
        cell.configureCell(result: resultsArr[type.rawValue][indexPath.row])
        return cell
    }
}
