//
//  SettingView.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit

final class SettingView: BaseView {
    
    lazy var settingButtonItem = UIBarButtonItem().then {
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let settingImage = UIImage(systemName: "gearshape", withConfiguration: config)
        $0.image = settingImage
        $0.style = .plain
    }
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        
    }
    
    override func configureConstraints() {

    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.rightBarButtonItem = settingButtonItem
        vc.navigationController?.navigationBar.tintColor = Colors.blackDescription
    }
}
