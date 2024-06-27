//
//  SearchDetailViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit
import Alamofire
import Toast

class SearchDetailViewController: BaseViewController {

    var customView = SearchDetailView()
    
    var similarMovieResult = SearchMovieResult.dummy
    var recommendMovieResult = SearchMovieResult.dummy
    var posterResult = PosterResult.dummy
    
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
        SearchResult.shared.searchRequest2(url: APIURL.posterUrl) { posterResult in
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
        switch collectionView {
        case customView.similarCollectionView:
            return similarMovieResult.results.count
        case customView.recommendCollectionView:
            return recommendMovieResult.results.count
        default:
            return posterResult.backdrops.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie: SearchMovie
        
        switch collectionView {
        case customView.similarCollectionView:
            movie = similarMovieResult.results[indexPath.row]
        case customView.recommendCollectionView:
            movie = recommendMovieResult.results[indexPath.row]
        default:
            movie = SearchMovie(id: 0, title: "", backdropPath: posterResult.backdrops[indexPath.row].posterUrl)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        cell.configureCell(movie: movie)
        cell.removeGradient()
        return cell
    }
}
