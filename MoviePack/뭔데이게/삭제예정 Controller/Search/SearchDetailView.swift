//
//  SearchDetailView.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit
import Toast
import YoutubePlayer_in_WKWebView

class SearchDetailView: BaseView {
    
    var previewVideoView = {
        let view = WKYTPlayerView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .darkGray
        return view
    }()
    
    let searchDetailTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(SearchDetailTableViewCell.self, forCellReuseIdentifier: SearchDetailTableViewCell.description())
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func configureSubViews() {
        self.addSubview(previewVideoView)
        self.addSubview(searchDetailTableView)
    }
    
    override func configureConstraints() {
        previewVideoView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        
        searchDetailTableView.snp.makeConstraints { make in
            make.top.equalTo(previewVideoView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}
