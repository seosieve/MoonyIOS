//
//  UINavigationController + Extension.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import UIKit
import Then

extension UIViewController {
    //Custom Round Shape BackButton
    func setCustomBackButton() {
        let backButton = UIButton(type: .system).then {
            $0.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
            let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
            let image = UIImage(systemName: "chevron.left", withConfiguration: config)
            $0.setImage(image, for: .normal)
            $0.backgroundColor = Colors.blackContent.withAlphaComponent(0.5)
            $0.tintColor = Colors.blackAccent
            $0.layer.cornerRadius = 20
            $0.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        }
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}
