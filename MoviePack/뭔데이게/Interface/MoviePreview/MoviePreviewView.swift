//
//  MoviePreviewView.swift
//  MoviePack
//
//  Created by 서충원 on 7/15/24.
//

import UIKit

final class MoviePreviewView: BaseView {
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        
    }
    
    override func configureConstraints() {
        
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.setCustomBackButton()
    }
}
