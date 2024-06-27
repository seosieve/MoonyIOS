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
    
    var similarMovieResult = SearchMovieResult.dummy
    var recommendMovieResult = SearchMovieResult.dummy
    var posterResult = SearchMovieResult.dummy
    
    override func loadView() {
        self.view = customView
        customView.similarCollectionView.delegate = self
        customView.similarCollectionView.dataSource = self
        customView.recommendCollectionView.delegate = self
        customView.recommendCollectionView.dataSource = self
        customView.posterCollectionView.delegate = self
        customView.posterCollectionView.dataSource = self
    }
    
    override func configure() {

        APIURL.movieID = 940721
        
        let group = DispatchGroup()
        
        group.enter()
        SearchResult.shared.searchRequest(url: APIURL.similarMovieUrl) { searchMovieResult in
            guard let searchMovieResult else { return }
            self.similarMovieResult = searchMovieResult
            group.leave()
        }
        
        group.enter()
        SearchResult.shared.searchRequest(url: APIURL.recommendMovieUrl) { searchMovieResult in
            guard let searchMovieResult else { return }
            self.recommendMovieResult = searchMovieResult
            group.leave()
        }
        
        group.enter()
        SearchResult.shared.searchRequest(url: APIURL.posterUrl) { posterResult in
            guard let posterResult else { return }
            self.posterResult = posterResult
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.customView.similarCollectionView.reloadData()
            self.customView.recommendCollectionView.reloadData()
            self.customView.posterCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovieResult.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        cell.removeGradient()
        
        switch collectionView {
        case customView.similarCollectionView:
            print("aa")
        case customView.recommendCollectionView:
            print("bb")
        default:
            print("cc")
        }
        
        return cell
    }
}
