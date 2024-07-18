//
//  HomeViewController.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit
import Toast

final class HomeViewController: BaseViewController<HomeView, HomeViewModel> {
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///CollectionView Delegate
        baseView.rankCollectionView.dataSource = self
        baseView.trendCollectionView.dataSource = self
        ///Rank Card Clicked
        NotificationCenter.default.addObserver(self, selector: #selector(rankCardClicked(_:)), name: Names.Noti.rank, object: nil)
        ///Trend Type Button
        baseView.movieButton.addTarget(self, action: #selector(trendTypeButtonClicked), for: .touchUpInside)
        baseView.peopleButton.addTarget(self, action: #selector(trendTypeButtonClicked), for: .touchUpInside)
        baseView.tvButton.addTarget(self, action: #selector(trendTypeButtonClicked), for: .touchUpInside)
    }
    
    override func bindData() {
        view.makeToastActivity(.center)
        viewModel.kobisBindingArr.bind { result in
            guard !result.contains(where: { $0 == nil }) else { return }
            self.baseView.rankCollectionView.reloadData()
            self.view.hideToastActivity()
        }
        
        viewModel.outputKobisDate.bind { result in
            guard let result else { return }
            self.baseView.dateLabel.text = result
        }
        
        viewModel.inputTypeButtonTrigger.bind { result in
            guard result != nil else { return }
            self.baseView.trendCollectionView.reloadData()
            self.baseView.trendCollectionView.scrollToItem(at: [0,0], at: .left, animated: true)
        }
    }
    
    @objc func rankCardClicked(_ notification: Notification) {
        guard let index = notification.object as? Int else { return }
        let viewModel = MovieInfoViewModel()
        viewModel.movieName.value = self.viewModel.kobisArr.value[index].movieNm
        viewModel.searchMovieResult.value = self.viewModel.kobisBindingArr.value[index]
        let vc = MovieInfoViewController(view: MovieInfoView(), viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func trendTypeButtonClicked(_ sender: UIButton) {
        baseView.trendTypeButtonAnimation(sender.tag)
        viewModel.inputTypeButtonTrigger.value = sender.tag
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == baseView.rankCollectionView {
            return viewModel.kobisArr.value.count
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
            ///Configure Cell
            let kobis = viewModel.kobisArr.value[indexPath.row]
            let kobisBinding = viewModel.kobisBindingArr.value[indexPath.row]
            cell.configureCell(kobis)
            cell.configureCell(kobisBinding)
            return cell
        } else {
            let identifier = TrendCollectionViewCell.identifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TrendCollectionViewCell
            guard let cell else { return UICollectionViewCell() }
            ///Configure Cell
            switch viewModel.inputTypeButtonTrigger.value {
            case 0:
                let movie = viewModel.trendMovieArr[indexPath.row]
                cell.configureCell(movie)
            case 1:
                let person = viewModel.trendPersonArr[indexPath.row]
                cell.configureCell(person)
            case 2:
                let tv = viewModel.trendTVArr[indexPath.row]
                cell.configureCell(tv)
            default:
                break
            }
            return cell
        }
    }
}
