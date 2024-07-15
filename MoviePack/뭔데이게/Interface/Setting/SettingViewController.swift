//
//  SettingViewController.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import Foundation

final class SettingViewController: BaseViewController<SettingView, SettingViewModel> {
    
    override func configureView() {
        baseView.configureNavigationController(self)
    }
}
