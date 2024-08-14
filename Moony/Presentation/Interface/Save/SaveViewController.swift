//
//  SaveViewController.swift
//  Moony
//
//  Created by 서충원 on 7/13/24.
//

import Foundation

final class SaveViewController: BaseViewController<SaveView, SaveViewModel> {
    
    override func configureView() {
        baseView.configureNavigationController(self)
    }
}
