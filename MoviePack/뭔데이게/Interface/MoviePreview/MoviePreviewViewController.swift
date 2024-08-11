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
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
    }
    
    override func configureRx() {
        ///Input
        let input = MoviePreviewViewModel.Input()
        ///Output
        let output = viewModel.transform(input: input)
        
        let (identifier, cellType) = (PreviewCollectionViewCell.description(), PreviewCollectionViewCell.self)
        
        output.videoList
            .bind(to: baseView.previewCollectionView.rx.items(cellIdentifier: identifier, cellType: cellType)) { item, element, cell in
                cell.configureCell(key: element.key)
            }
            .disposed(by: disposeBag)
    }
}
