//
//  UpcomingViewController.swift
//  MoviePack
//
//  Created by 서충원 on 8/10/24.
//

import UIKit
import RxSwift
import RxCocoa

final class UpcomingViewController: BaseViewController<UpcomingView, UpcomingViewModel> {
    
    let genre = Observable.just(Names.Genre.dictionary)
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
        let input = UpcomingViewModel.Input(trigger: Observable.just(()))
        ///Output
        let output = viewModel.transform(input: input)
        
        output.movieList
            .bind(with: self) { owner, value in
                owner.updateSnapshot(value)
            }
            .disposed(by: disposeBag)
        
        
        
        let identifier = GenreCollectionViewCell.description()
        let cell = GenreCollectionViewCell.self
        
        genre.bind(to: baseView.genreCollectionView.rx.items(cellIdentifier: identifier, cellType: cell)) { row, element, cell in
            
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
