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
    }
}
