//
//  MoviePreviewViewController.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import UIKit
import RxSwift

final class MoviePreviewViewController: BaseViewController<MoviePreviewView, MoviePreviewViewModel> {
    
    let disposeBag = DisposeBag()
    
    var movieId: Int?
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
    }
    
    override func configureRx() {
        ///Input
        let input = MoviePreviewViewModel.Input(movieId: movieId)
        ///Output
        let output = viewModel.transform(input: input)
        
        let video = (identifier: PreviewCollectionViewCell.description(), cellType: PreviewCollectionViewCell.self)
        let poster = (identifier: PosterCollectionViewCell.description(), cellType: PosterCollectionViewCell.self)
        
        output.videoList
            .bind(to: baseView.previewCollectionView.rx.items(cellIdentifier: video.identifier, cellType: video.cellType)) { item, element, cell in
                cell.configureCell(key: element.key)
            }
            .disposed(by: disposeBag)
        
        output.posterList
            .bind(to: baseView.posterCollectionView.rx.items(cellIdentifier: poster.identifier, cellType: poster.cellType)) { item, element, cell in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
    }
}
