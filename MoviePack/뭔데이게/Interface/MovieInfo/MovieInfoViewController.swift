//
//  MovieInfoViewController.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import UIKit
import MetricKit

final class MovieInfoViewController: BaseViewController<MovieInfoView, MovieInfoViewModel> {
    
    var list = [UIImage(named: "베테랑"), UIImage(named: "부산행"), UIImage(named: "서울의봄"), UIImage(named: "명량"), UIImage(named: "Movie")]
    
    override func configureView() {
        
        list.insert(list[list.count-1], at: 0)
        list.append(list[1])
        
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
    
    @objc func previewButtonClicked() {
        let vc = MoviePreviewViewController(view: MoviePreviewView(), viewModel: MoviePreviewViewModel())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MovieInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = PosterCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? PosterCollectionViewCell
        guard let cell else { return UICollectionViewCell() }
        
        cell.posterImageView.image = list[indexPath.row]
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let count = list.count
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CastTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CastTableViewCell
        guard let cell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


