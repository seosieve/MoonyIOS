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

class SearchViewController: BaseViewController<SearchView, BaseViewModel> {
    
    var searchMovieResult: MovieResult?
    var previousWord = ""
    var page = 1
    
    override func configureView() {
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = listButton
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "SEARCH"
        baseView.searchBar.delegate = self
        baseView.searchCollectionView.delegate = self
        baseView.searchCollectionView.dataSource = self
        baseView.searchCollectionView.prefetchDataSource = self
    }
    
    //Wrapping with Additional Work
    func search(word: String) {
        view.makeToastActivity(.center)
        NetworkManager.shared.networkRequest(router: Network.search(word: word, page: page), type: MovieResult.self) { result in
            switch result {
            case .success(let success):
                self.baseView.configureView(isEmpty: true)
                switch self.page {
                case 1:
                    self.searchMovieResult = success
                default:
                    self.searchMovieResult?.results += success.results
                }
                self.baseView.searchCollectionView.reloadData()
                self.view.hideToastActivity()
                
                if self.page == 1 {
                    if success.totalResults == 0 {
                        self.baseView.configureView(isEmpty: false)
                    } else {
                        self.baseView.searchCollectionView.scrollToItem(at: [0,0], at: .top, animated: true)
                    }
                }
            case .failure(let failure):
                print(failure)
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
        return searchMovieResult?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movie = searchMovieResult?.results[indexPath.row] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        cell.configureCell(result: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = searchMovieResult?.results[indexPath.row].id, let title = searchMovieResult?.results[indexPath.row].title else { return }
        let vc = SearchDetailViewController(id: id, title: title)
        let backBarButtonItem = UIBarButtonItem(title: "")
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(vc, animated: true)
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
        let movieCount = searchMovieResult!.results.count - 1
        print(item, movieCount)
        let totalPage = searchMovieResult!.totalPages
        if movieCount == item && totalPage != page {
            guard let text = baseView.searchBar.text else { return }
            page += 1
            search(word: text)
        }
    }
}
