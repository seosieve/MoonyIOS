//
//  BaseViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(#function, "BaseViewController")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        print(#function, "BaseViewController")
    }
    
    func configure() {
        print(#function, "BaseViewController")
    }
}
