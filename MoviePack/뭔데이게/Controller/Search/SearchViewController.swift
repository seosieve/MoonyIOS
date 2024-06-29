//
//  SearchViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/11/24.
//

import UIKit
import Alamofire
import Kingfisher
import Toast

class SearchViewController: BaseViewController {
    
    var customView = SearchView()
    
    var searchMovieResult = SearchMovieResult()
    var previousWord = ""
    var page = 1
    
    override func loadView() {
        self.view = customView
    }
    
    override func configure() {
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = listButton
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "SEARCH"
        customView.searchBar.delegate = self
        customView.searchCollectionView.delegate = self
        customView.searchCollectionView.dataSource = self
        customView.searchCollectionView.prefetchDataSource = self
    }
    
    //Wrapping with Additional Work
    func search(word: String) {
        view.makeToastActivity(.center)
        searchRequest(word: word) { searchMovieResult in
            guard let searchMovieResult else { return }
            self.customView.configureView(isEmpty: true)
            switch self.page {
            case 1:
                self.searchMovieResult = searchMovieResult
            default:
                self.searchMovieResult.results += searchMovieResult.results
            }
            self.customView.searchCollectionView.reloadData()
            self.view.hideToastActivity()
            
            if self.page == 1 {
                if searchMovieResult.totalResults == 0 {
                    self.customView.configureView(isEmpty: false)
                } else {
                    self.customView.searchCollectionView.scrollToItem(at: [0,0], at: .top, animated: true)
                }
            }
        }
    }
    
    //Search Request Logic
    func searchRequest(word: String, handler: @escaping (SearchMovieResult?) -> ()) {
        let url = APIURL.searchMovieUrl + "&query=\(word)" + "&page=\(page)"
        
        AF.request(url).responseDecodable(of: SearchMovieResult.self) { response in
            switch response.result {
            case .success(let value):
                handler(value)
            case .failure(let error):
                print(error)
                handler(nil)
            }
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        guard previousWord != text else { return }
        previousWord = text
        page = 1
        search(word: text)
        view.endEditing(true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovieResult.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = searchMovieResult.results[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        cell.configureCell(result: movie)
        return cell
    }
}

//MARK: - UICollectionViewDataSourcePrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            paginationAction(indexPath: indexPath)
        }
    }
    
    func paginationAction(indexPath: IndexPath) {
        let item = indexPath.item
        let movieCount = searchMovieResult.results.count - 1
        print(item, movieCount)
        let totalPage = searchMovieResult.totalPages
        if movieCount == item && totalPage != page {
            guard let text = customView.searchBar.text else { return }
            page += 1
            search(word: text)
        }
    }
}
