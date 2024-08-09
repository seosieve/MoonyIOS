//
//  SearchViewModel.swift
//  MoviePack
//
//  Created by 서충원 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel {
    
    
    
    
    
    
    //Wrapping with Additional Work
//    func search(word: String) {
//        view.makeToastActivity(.center)
//        NetworkManager.shared.networkRequest(router: Network.search(word: word, page: page), type: SearchResult.self) { result in
//            switch result {
//            case .success(let success):
//                self.baseView.configureView(isEmpty: true)
//                switch self.page {
//                case 1:
//                    self.searchMovieResult = success
//                default:
//                    self.searchMovieResult?.results += success.results
//                }
//                self.baseView.movieCollectionView.reloadData()
//                self.view.hideToastActivity()
//                
//                if self.page == 1 {
//                    if success.totalResults == 0 {
//                        self.baseView.configureView(isEmpty: false)
//                    } else {
//                        self.baseView.movieCollectionView.scrollToItem(at: [0,0], at: .top, animated: true)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
    
}
