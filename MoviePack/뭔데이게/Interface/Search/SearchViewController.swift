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
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController<SearchView, SearchViewModel> {
    
    let data = ["dawdwaawd", "ss", "adad", "dawdwad", "aadda", "2"]
    var dataSource: UICollectionViewDiffableDataSource<String, Movie>!
    
    let disposeBag = DisposeBag()
    
    var searchMovieResult: SearchResult?
    var previousWord = ""
    var page = 1
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///Keyboard Down When Tapped
        hideKeyboardWhenTappedAround()
        ///Word Collection View
        baseView.wordCollectionView.delegate = self
        baseView.wordCollectionView.dataSource = self
        
        ///Diffable DataSource
//        configureDataSource()
//        updateSnapshot([])
        ///Search Collection View
        baseView.movieCollectionView.delegate = self
//        baseView.movieCollectionView.prefetchDataSource = self
    }
    
    override func configureRx() {
        baseView.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .withLatestFrom(baseView.searchTextField.rx.text.orEmpty)
            .subscribe(onNext: { value in
                let value = value.replacingOccurrences(of: " ", with: "")
                print(value)
                self.baseView.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///Make Reusable Cell
        let identifier = WordCollectionViewCell.description()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? WordCollectionViewCell
        guard let cell else { return UICollectionViewCell() }
        ///Configure Cell
        cell.configureCell(word: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = searchMovieResult?.results[indexPath.row].id, let title = searchMovieResult?.results[indexPath.row].name else { return }
        let vc = SearchDetailViewController(id: id, title: title)
        let backBarButtonItem = UIBarButtonItem(title: "")
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == baseView.wordCollectionView {
            let text = data[indexPath.item]
            
            // 텍스트에 따른 라벨 크기 계산
            let size = (text as NSString).boundingRect(
                with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 44),
                options: .usesLineFragmentOrigin,
                attributes: [.font: UIFont.systemFont(ofSize: 16)],
                context: nil
            ).size
            
            return CGSize(width: size.width + 30, height: 36)
        } else {
            return CGSize(width: 400, height: 36)
        }
    }
}
