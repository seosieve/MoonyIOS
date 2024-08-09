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
    
    let prefetchItem = PublishSubject<Int>()
    
    let disposeBag = DisposeBag()
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///Initialize UI Menu
        baseView.configureInitialMenu()
        ///Keyboard Down When Tapped
        hideKeyboardWhenTappedAround()
        ///Word Collection View
        baseView.wordCollectionView.delegate = self
        baseView.wordCollectionView.dataSource = self
        ///Diffable DataSource
        configureDataSource()
        ///Search Collection View
        baseView.searchCollectionView.delegate = self
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
        
        
        
        baseView.searchCollectionView.rx.itemSelected
            .subscribe(with: self, onNext: { owner, value in
                
            })
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
