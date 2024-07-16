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
    var trendArr: [Trend] = []
    var creditsArr: [CreditsResult] = []
    
    var topContainerView = {
        let view = UIView()
        view.backgroundColor = Colors.blackBackground
        return view
    }()
    
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
        self.view.backgroundColor = Colors.blackBackground
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = listButton
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.tintColor = .darkGray
    }

    func configureSubviews() {
        view.addSubview(topContainerView)
        view.addSubview(trendTableView)
    }
    
    func configureConstraints() {
        topContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        trendTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func trendRequest() {
        view.makeToastActivity(.center)
        NetworkManager.shared.networkRequest(router: .trend, type: TrendResult.self) { result in
            switch result {
            case .success(let success):
                
                self.trendArr = success.results
                self.creditsArr = Array(repeating: CreditsResult(id: 0, cast: []), count: success.results.count)
                
                let dispatchGroup = DispatchGroup()
                
                for (index, result) in success.results.enumerated() {
                    dispatchGroup.enter()
                    self.creditsRequest(id: result.id, index: index, dispatchGroup: dispatchGroup)
                }
                
                dispatchGroup.notify(queue: .main) {
                    self.view.hideToastActivity()
                    self.trendTableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func creditsRequest(id: Int, index: Int, dispatchGroup: DispatchGroup) {
        NetworkManager.shared.networkRequest(router: .credit(id: id), type: CreditsResult.self) { result in
            switch result {
            case .success(let success):
                self.creditsArr[index] = success
            case .failure(let failure):
                print(failure)
            }
            dispatchGroup.leave()
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
        let credit = creditsArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TrendTableViewCell
        cell.characterLabel.text = "\(credit.cast[0].name), \(credit.cast[1].name), \(credit.cast[2].name)"
        cell.configureCell(trend: trend)
        cell.detailButton.addTarget(self, action: #selector(detailButtonPressed), for: .touchUpInside)
        
        return cell
    }
}
