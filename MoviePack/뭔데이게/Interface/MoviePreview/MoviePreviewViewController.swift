//
//  MoviePreviewViewController.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import UIKit

final class MoviePreviewViewController: BaseViewController<MoviePreviewView, MoviePreviewViewModel> {
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///CollectionView Delegate
        baseView.previewCollectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MoviePreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = PreviewCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? PreviewCollectionViewCell
        guard let cell else { return UICollectionViewCell() }
        cell.configureCell()        
        return cell
    }
}
