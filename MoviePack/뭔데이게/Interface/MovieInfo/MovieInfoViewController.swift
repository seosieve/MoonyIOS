//
//  MovieInfoViewController.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import UIKit

class MovieInfoViewController: BaseViewController<MovieInfoView, MovieInfoViewModel> {
    
    override func configureView() {
        ///Navigation Controller
        baseView.configureNavigationController(self)
        ///TableView Delegate
        baseView.castTableView.delegate = self
        baseView.castTableView.dataSource = self
    }
}

extension MovieInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CastTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CastTableViewCell
        guard let cell else { return UITableViewCell() }
        
        return cell
    }
}


