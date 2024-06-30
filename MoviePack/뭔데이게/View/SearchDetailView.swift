//
//  SearchDetailView.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit

class SearchDetailView: BaseView {
    
    let searchDetailTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(SearchDetailTableViewCell.self, forCellReuseIdentifier: SearchDetailTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func configureSubviews() {
        self.addSubview(searchDetailTableView)
    }
    
    override func configureConstraints() {
        searchDetailTableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}
