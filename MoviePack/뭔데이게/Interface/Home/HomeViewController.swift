//
//  HomeViewController.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit

class HomeViewController: BaseViewController<HomeView, HomeViewModel> {
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///CollectionView Delegate
        baseView.rankCollectionView.dataSource = self
        baseView.trendCollectionView.dataSource = self
        ///Rank Card Clicked
        NotificationCenter.default.addObserver(self, selector: #selector(rankCardClicked), name: Names.Noti.rank, object: nil)
    }
    
    @objc func rankCardClicked() {
        let vc = MovieInfoViewController(view: MovieInfoView(), viewModel: MovieInfoViewModel())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == baseView.rankCollectionView {
            return 10
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == baseView.rankCollectionView {
            let identifier = RankCollectionViewCell.identifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? RankCollectionViewCell
            guard let cell else { return UICollectionViewCell() }
            ///Carousel Animation
            indexPath.row == baseView.previousIndex ? baseView.increaseAnimation(zoomCell: cell) : baseView.decreaseAnimation(zoomCell: cell)
            return cell
        } else {
            let identifier = TrendCollectionViewCell.identifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TrendCollectionViewCell
            guard let cell else { return UICollectionViewCell() }
            
            return cell
        }
    }
}
