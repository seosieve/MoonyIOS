//
//  BaseViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

class BaseViewController<View: BaseView, ViewModel: BaseViewModel>: UIViewController {
    
    let baseView: View
    let viewModel: ViewModel
    
    init(view: View, viewModel: ViewModel) {
        self.baseView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() { }
}
