//
//  CustomTabBarController.swift
//  MoviePack
//
//  Created by 서충원 on 7/12/24.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItems()
        configureTabBar(space: 70, addHeight: 11)
    }
    
    func configureTabBarItems() {
        let mapViewController = UINavigationController(rootViewController: MovieRankViewController())
        mapViewController.tabBarItem.image = UIImage(systemName: "movieclapper")
        mapViewController.tabBarItem.selectedImage = UIImage(systemName: "movieclapper.fill")
        
        let addlistViewController = UINavigationController(rootViewController: TrendViewController())
        addlistViewController.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")
        addlistViewController.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.clipboard.fill")
        
        let userViewController = UINavigationController(rootViewController: SearchViewController())
        userViewController.tabBarItem.image = UIImage(systemName: "popcorn")
        userViewController.tabBarItem.selectedImage = UIImage(systemName: "popcorn.fill")
        
        viewControllers = [mapViewController, addlistViewController, userViewController]
    }
    
    func configureTabBar(space: CGFloat, addHeight: CGFloat) {
        let layer = CAShapeLayer()
        let x: CGFloat = space
        let width: CGFloat = tabBar.bounds.width - (x * 2)
        let baseHeight: CGFloat = 49
        let currentHeight: CGFloat = baseHeight + addHeight
        let y: CGFloat = -(5.5 + addHeight/2)
        
        let rectSize = CGRect(x: x, y: y, width: width, height: currentHeight)
        let path = UIBezierPath(roundedRect: rectSize, cornerRadius: currentHeight / 2).cgPath
        layer.path = path
        ///Background Color
        layer.fillColor = UIColor.white.cgColor
        ///Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        ///Item Color
        self.tabBar.tintColor = UIColor.systemCyan
        self.tabBar.unselectedItemTintColor = UIColor.systemGray5
        ///TabBar Appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.stackedItemWidth = width / 5
        appearance.stackedItemPositioning = .centered

        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
}
