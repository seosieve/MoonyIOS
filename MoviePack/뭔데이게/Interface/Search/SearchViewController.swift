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
    
    let data = Observable.just(["도라에몽", "진구", "지구 교향곡", "극장판", "aadda", "2"])
    var dataSource: UICollectionViewDiffableDataSource<String, Movie>!
    
    let prefetchItem = PublishSubject<Int>()
    
    let disposeBag = DisposeBag()
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///Initialize UI Menu
        baseView.configureInitialMenu()
        ///Keyboard Down When Tapped
        hideKeyboardWhenTappedAround()
        ///Word Collection View Delegate
        baseView.wordCollectionView.delegate = self
        ///Diffable DataSource
        configureDataSource()
        ///Search Collection View Prefetching
        baseView.searchCollectionView.prefetchDataSource = self
    }
    
    override func configureRx() {
        ///Input
        let input = SearchViewModel.Input(searchButtonTap: baseView.searchTextField.rx.controlEvent(.editingDidEndOnExit),
                                          searchText: baseView.searchTextField.rx.text.orEmpty,
                                          prefetchItem: prefetchItem)
        ///Output
        let output = viewModel.transform(input: input)
        
        output.movieList
            .bind(with: self) { owner, value in
                owner.updateSnapshot(value)
            }
            .disposed(by: disposeBag)
        
        output.emptyText
            .bind(with: self) { owner, _ in
                owner.view.makeToast(Names.PlaceHolder.emptyText, position: .center)
            }
            .disposed(by: disposeBag)
        
        output.emptyResult
            .bind(to: baseView.emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.searchButtonTap
            .bind(with: self) { owner, value in
                //Ignore when List is Empty
                guard !output.movieList.value.isEmpty else { return }
                owner.baseView.searchCollectionView.scrollToItem(at: [0,0], at: .top, animated: true)
            }
            .disposed(by: disposeBag)
        
        data
            .bind(to: baseView.wordCollectionView.rx.items(cellIdentifier: WordCollectionViewCell.description(), cellType: WordCollectionViewCell.self)) { row, element, cell in
                cell.configureCell(word: element)
            }
            .disposed(by: disposeBag)
        

        

    }
}

//MARK: - Diffable DataSource
extension SearchViewController {
    //Configure Cell
    private func photoCellRegistration() -> UICollectionView.CellRegistration<SearchCollectionViewCell, Movie> {
        return UICollectionView.CellRegistration{ cell, indexPath, itemIdentifier in
            cell.configureCell(result: itemIdentifier)
        }
    }
    
    private func configureDataSource() {
        let collectionView = baseView.searchCollectionView
        let cellRegistration = photoCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    //Snapshot
    private func updateSnapshot(_ photoList: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, Movie>()
        snapshot.appendSections(["main"])
        snapshot.appendItems(photoList, toSection: "main")
        dataSource.apply(snapshot)
    }
}

//MARK: - UICollectionViewDataSourcePrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            prefetchItem.onNext(indexPath.item)
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var text: String = ""
        
        data
            .subscribe(onNext: { array in
                text = array[indexPath.row]
            })
            .disposed(by: disposeBag)
        
        ///Get Text Size
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 36)
        let attribures: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16)]
        let textSize = (text as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribures, context: nil).size
        
        return CGSize(width: textSize.width + 50, height: 36)
    }
}
