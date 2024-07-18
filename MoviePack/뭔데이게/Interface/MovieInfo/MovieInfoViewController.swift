//
//  MovieInfoViewController.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import UIKit
import Kingfisher

final class MovieInfoViewController: BaseViewController<MovieInfoView, MovieInfoViewModel> {
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///Preview Button
        baseView.previewButton.addTarget(self, action: #selector(previewButtonClicked), for: .touchUpInside)
        ///CollectionView Delegate
        baseView.posterCollectionView.delegate = self
        baseView.posterCollectionView.dataSource = self
        ///TableView Delegate
        baseView.castTableView.delegate = self
        baseView.castTableView.dataSource = self
    }
    
    override func bindData() {
        viewModel.movieName.bind { result in
            guard let result else { return }
            self.baseView.titleLabel.text = result
        }
        
        viewModel.moviePosterArr.bind { result in
            guard !result.isEmpty else { return }
            print(result.count)
            self.baseView.posterCollectionView.reloadData()
        }
        
        viewModel.movieOverview.bind { result in
            guard let result else { return }
            self.baseView.configureOverview(result)
            self.baseView.configureMovieInfo(self.viewModel.searchMovieResult.value)
        }
        
        viewModel.movieCreditArr.bind { result in
            guard !result.isEmpty else { return }
            self.baseView.castTableView.reloadData()
            self.baseView.castTableView.snp.updateConstraints { make in
                make.height.equalTo(self.viewModel.movieCreditArr.value.count * 120)
            }
        }
    }
    
    @objc func previewButtonClicked() {
        let vc = MoviePreviewViewController(view: MoviePreviewView(), viewModel: MoviePreviewViewModel())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MovieInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.moviePosterArr.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = PosterCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? PosterCollectionViewCell
        guard let cell else { return UICollectionViewCell() }
        let poster = viewModel.moviePosterArr.value[indexPath.row]
        let url = URL(string: poster.posterUrl)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let count = viewModel.moviePosterArr.value.count
        let cellWidth = MovieInfoViewController.screenSize.width
        
        if scrollView.contentOffset.x == 0 {
            scrollView.setContentOffset(.init(x: cellWidth * Double(count-2), y: scrollView.contentOffset.y), animated: false)
        }
        if scrollView.contentOffset.x == Double(count-1) * cellWidth {
            scrollView.setContentOffset(.init(x: cellWidth, y: scrollView.contentOffset.y), animated: false)
        }
        
        print(round(scrollView.contentOffset.x / cellWidth))
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.movieCreditArr.value.count)
        return viewModel.movieCreditArr.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CastTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CastTableViewCell
        guard let cell else { return UITableViewCell() }
        ///Configure Cell
        let person = viewModel.movieCreditArr.value[indexPath.row]
        cell.configureCell(person: person)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


