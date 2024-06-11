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

class SearchViewController: UIViewController, Configure {
    
    let identifier = SearchCollectionViewCell.identifier
    var searchMovieResult = SearchMovieResult.dummy
    var previousWord = ""
    var page = 1
    
    lazy var searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "영화 제목을 검색해보세요."
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.setSearchTextFieldItemColor(to: .systemGray2)
        searchBar.delegate = self
        return searchBar
    }()
    
    var layout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
        return layout
    }
    
    lazy var searchCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    func setViews() {
        view.backgroundColor = .black
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = listButton
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "SEARCH"
    }
    
    func configureSubviews() {
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
    }
    
    func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    //Wrapping with Additional Work
    func search(word: String) {
        view.makeToastActivity(.center)
        searchRequest(word: word) { searchMovieResult in
            guard let searchMovieResult else { return }
            switch self.page {
            case 1:
                self.searchMovieResult = searchMovieResult
            default:
                self.searchMovieResult.results += searchMovieResult.results
            }
            self.searchCollectionView.reloadData()
            self.view.hideToastActivity()
            
            if self.page == 1 {
                self.searchCollectionView.scrollToItem(at: [0,0], at: .top, animated: true)
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

//MARK: - //MARK: - UICollectionViewFlowLayout
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        guard previousWord != text else { return }
        previousWord = text
        page = 1
        search(word: text)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovieResult.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = searchMovieResult.results[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SearchCollectionViewCell
        let url = URL(string: movie.posterUrl)
        cell.searchImageView.kf.setImage(with: url)
        cell.titleLabel.text = movie.title
        
        
   
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
            guard let text = searchBar.text else { return }
            page += 1
            search(word: text)
        }
    }
}

//MARK: - UICollectionViewFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 0, height: 0) }
        let screenWidth = collectionView.frame.width
        let inset = layout.sectionInset.left + layout.sectionInset.right
        let spacing = layout.minimumInteritemSpacing
        let width = (screenWidth - inset - spacing * 2) / 3
        let height = width + 40
        return CGSize(width: width, height: height)
    }
}
