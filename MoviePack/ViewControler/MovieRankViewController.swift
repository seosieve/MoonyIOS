//
//  MovieRankViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/6/24.
//

import UIKit
import SnapKit

class MovieRankViewController: UIViewController {

    let movieBackgroundView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Movie")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let dimBackgroundView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    let dateTextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        return textField
    }()
    
    let searchButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("SEARCH", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        return button
    }()
    
    let textFieldDivider = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 1
        return view
    }()
    
    lazy var movieTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieRankTableViewCell.self, forCellReuseIdentifier: MovieRankTableViewCell.identifier)
        tableView.rowHeight = 80
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        view.addSubview(movieBackgroundView)
        view.addSubview(dimBackgroundView)
        view.addSubview(searchButton)
        view.addSubview(dateTextField)
        view.addSubview(textFieldDivider)
        view.addSubview(movieTableView)
    }
    
    func configureConstraints() {
        movieBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dimBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().inset(20)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.centerY.equalTo(searchButton)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-20)
            make.height.equalTo(40)
        }
                
        textFieldDivider.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(dateTextField)
            make.height.equalTo(2)
        }
        
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(textFieldDivider).offset(30)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension MovieRankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieRankTableViewCell.identifier, for: indexPath) as! MovieRankTableViewCell
        return cell
    }
    
    
}
