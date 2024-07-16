//
//  SearchDetailViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/24/24.
//

import UIKit
import Toast
import YoutubePlayer_in_WKWebView

enum CollectionViewType: Int {
    case similar
    case recommend
    case poster
    
    var title: String {
        switch self {
        case .similar:
            return "비슷한 영화"
        case .recommend:
            return "추천 영화"
        case .poster:
            return "포스터"
        }
    }
    
    var layout: UICollectionViewFlowLayout {
        switch self {
        case .similar, .recommend:
            SearchDetailTableViewCell.flowLayout(width: 120, height: 180)
        case .poster:
            SearchDetailTableViewCell.flowLayout(width: 150, height: 180)
        }
    }
}

class SearchDetailViewController: BaseViewController<SearchDetailView, HomeViewModel> {
    
    var resultsArr: [[Movie]] = Array(repeating: [Movie](), count: 3)
    var page: [Int] = [1,1]
    
    var id: Int!
    var navTitle: String!
    
    init(id: Int, title: String) {
        super.init(view: SearchDetailView(), viewModel: HomeViewModel())
        self.id = id
        self.navTitle = title
    }
    
    override func configureView() {
        navigationItem.title = navTitle
        
        baseView.searchDetailTableView.delegate = self
        baseView.searchDetailTableView.dataSource = self
        
        NetworkManager.shared.networkRequest(router: .video(id: id), type: VideoResult.self) { result in
            switch result {
            case .success(let success):
                guard let key = success.results.first?.key else { return }
                self.baseView.previewVideoView.load(withVideoId: key)
            case .failure(let failure):
                print(failure)
            }
        }
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.networkRequest(router: .similar(id: id, page: 1), type: SearchResult.self) { result in
            switch result {
            case .success(let success):
                self.resultsArr[0] = success.results
            case .failure(let failure):
                print(failure)
            }
            
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.networkRequest(router: .recommend(id: id, page: 1), type: SearchResult.self) { result in
            switch result {
            case .success(let success):
                self.resultsArr[1] = success.results
            case .failure(let failure):
                print(failure)
            }
            
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.networkRequest(router: .poster(id: id), type: PosterResult.self) { result in
            switch result {
            case .success(let success):
                print(success)
//                self.resultsArr[2] = success.backdrops
            case .failure(let failure):
                print(failure)
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.baseView.searchDetailTableView.reloadData()
        }
    }
}

extension SearchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailTableViewCell.identifier, for: indexPath) as? SearchDetailTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        guard let type = CollectionViewType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        cell.titleLabel.text = type.title
        cell.searchDetailCollectionView.collectionViewLayout = type.layout
        cell.type = type
        cell.resultsArr = resultsArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? SearchDetailTableViewCell else { return }
        guard cell.delegate == nil else { return }
        cell.delegate = self
    }
}

extension SearchDetailViewController: TableViewCellDelegate {
    func configureResult(type: CollectionViewType, completionHandler: @escaping ([Movie]) -> Void) {
        let index = type.rawValue
        page[index] += 1
        
        switch type {
        case .similar:
            NetworkManager.shared.networkRequest(router: .similar(id: 940721, page: page[index]), type: SearchResult.self) { result in
                switch result {
                case .success(let success):
                    completionHandler(success.results)
                case .failure(let failure):
                    print(failure)
                }
            }
        case .recommend:
            NetworkManager.shared.networkRequest(router: .recommend(id: 940721, page: page[index]), type: SearchResult.self) { result in
                switch result {
                case .success(let success):
                    completionHandler(success.results)
                case .failure(let failure):
                    print(failure)
                }
            }
        case .poster:
            break
        }
    }
}
