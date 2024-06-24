//
//  TrendViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class TrendViewController: UIViewController {
    
    let identifier = TrendTableViewCell.identifier
    let trendUrlString = APIURL.trendUrl
    var trendArr: [Trend] = [] {
        didSet {
            if trendArr.count != 0 {
                trendTableView.reloadData()
            }
        }
    }
    var creditsArr = Array(repeating: CreditsResult.makeDummy, count: 20)
    
    lazy var trendTableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendTableViewCell.self, forCellReuseIdentifier: identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        configureSubviews()
        configureConstraints()
        trendRequest()
    }
    
    func setViews() {
        view.backgroundColor = .white
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = listButton
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.tintColor = .darkGray
    }

    func configureSubviews() {
        view.addSubview(trendTableView)
    }
    
    func configureConstraints() {
        trendTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func trendRequest() {
        view.makeToastActivity(.center)
        AF.request(trendUrlString).responseDecodable(of: TrendResult.self) { response in
            switch response.result {
            case .success(let value):
                self.trendArr = value.results
            case .failure(let error):
                print(error)
            }
            self.view.hideToastActivity()
        }
    }
    
    func creditsRequest(id: Int, handler: @escaping (CreditsResult) -> ()) {
        APIURL.movieID = id
        AF.request(APIURL.creditsUrl).responseDecodable(of: CreditsResult.self) { response in
            switch response.result {
            case .success(let value):
                handler(value)
            case .failure(let error):
                print(error)
            }
            self.view.hideToastActivity()
        }
    }
    
    @objc func detailButtonPressed(_ sender: UIButton) {
        let hitPoint = sender.convert(CGPoint.zero, to: trendTableView)
        guard let indexPath = trendTableView.indexPathForRow(at: hitPoint) else { return }
        let vc = TrendDetailViewController()
        vc.trend = trendArr[indexPath.row]
        vc.creditsResult = creditsArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trend = trendArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TrendTableViewCell
        let id = trend.id
        creditsRequest(id: id) { CreditsResult in
            self.creditsArr[indexPath.row] = CreditsResult
            cell.characterLabel.text = "\(CreditsResult.cast[0].name), \(CreditsResult.cast[1].name), \(CreditsResult.cast[2].name)"
        }
        cell.configureCell(trend: trend)
        
        cell.detailButton.addTarget(self, action: #selector(detailButtonPressed), for: .touchUpInside)
        
        return cell
    }
}
