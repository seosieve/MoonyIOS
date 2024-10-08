//
//  UpcomingViewController.swift
//  Moony
//
//  Created by 서충원 on 8/10/24.
//

import UIKit
import RxSwift
import RxCocoa

final class UpcomingViewController: BaseViewController<UpcomingView, UpcomingViewModel> {
    
    var dataSource: UICollectionViewDiffableDataSource<String, Movie>!
    
    let disposeBag = DisposeBag()
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///Diffable DataSource
        configureDataSource()
    }
    
    override func configureRx() {
        ///Input
        let input = UpcomingViewModel.Input(sortChange: baseView.sortChange,
                                            genreSelect: baseView.genreCollectionView.rx.itemSelected,
                                            genreDeselect: baseView.genreCollectionView.rx.itemDeselected)
        ///Output
        let output = viewModel.transform(input: input)
        
        output.movieList
            .bind(with: self) { owner, value in
                guard !value.isEmpty else { return }
                owner.updateSnapshot(value)
            }
            .disposed(by: disposeBag)
        
        
        
        //MARK: - Genre Collection View
        let genre = (identifier: GenreCollectionViewCell.description(), cellType: GenreCollectionViewCell.self)
        
        Observable.just(Names.Genre.allCases)
            .bind(to: baseView.genreCollectionView.rx.items(cellIdentifier: genre.identifier, cellType: genre.cellType)) { item, element, cell in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
        
        ///Configure 'All' is Selected in Initial
        baseView.genreCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
        
        ///Select Animation
        output.genreSelect
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                guard let cell = owner.baseView.genreCollectionView.cellForItem(at: value) as? GenreCollectionViewCell else { return }
                cell.selectAnimation()
            }
            .disposed(by: disposeBag)
        
        ///Scroll to Top
        output.genreSelect
            .bind(with: self) { owner, _ in
                owner.baseView.upcomingCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.genreDeselect
            .bind(with: self) { owner, value in
                guard let cell = owner.baseView.genreCollectionView.cellForItem(at: value) as? GenreCollectionViewCell else { return }
                cell.deselectAction()
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - Diffable DataSource
extension UpcomingViewController {
    //Configure Cell
    private func photoCellRegistration() -> UICollectionView.CellRegistration<UpcomingCollectionViewCell, Movie> {
        return UICollectionView.CellRegistration{ cell, indexPath, itemIdentifier in
            cell.configureCell(result: itemIdentifier)
        }
    }
    
    private func configureDataSource() {
        let collectionView = baseView.upcomingCollectionView
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
