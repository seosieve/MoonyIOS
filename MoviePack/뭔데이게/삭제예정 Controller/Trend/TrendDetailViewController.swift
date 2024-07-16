//
//  TrendDetailViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class TrendDetailViewController: UIViewController {
    
    let overViewIdentifier = OverViewTableViewCell.identifier
    let castIdentifier = CastTableViewCell.identifier
    
    var trend: Movie?
    var creditsResult: CreditsResult?
    
    lazy var detailImageView = {
        let imageView = UIImageView()
        let url = URL(string: trend?.imageUrl ?? "")
        imageView.kf.setImage(with: url)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dimView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .black)
        label.textColor = .white
        label.text = trend?.title
        return label
    }()
    
    lazy var detailTableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OverViewTableViewCell.self, forCellReuseIdentifier: overViewIdentifier)
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: castIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    func setViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.topItem?.title = ""
        self.title = "출연/제작"
        let url = URL(string: trend?.imageUrl ?? "")
        detailImageView.kf.setImage(with: url)
    }
    
    func configureSubviews() {
        view.addSubview(detailImageView)
        view.addSubview(dimView)
        view.addSubview(titleLabel)
        view.addSubview(detailTableView)
    }
    
    func configureConstraints() {
        detailImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        
        dimView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(detailImageView).inset(20)
        }
        
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(detailImageView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    @objc func detailButtonPressed(_ sender: UIButton) {
        print(#function)
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TrendDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "OverView"
        } else {
            return "Cast"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return creditsResult?.cast.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: overViewIdentifier, for: indexPath) as! OverViewTableViewCell
            cell.overViewLabel.text = trend?.overview
            return cell
        } else {
            guard let person = creditsResult?.cast[indexPath.row] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: castIdentifier, for: indexPath) as! CastTableViewCell
            cell.configureCell(person: person)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 120
        }
    }
}
