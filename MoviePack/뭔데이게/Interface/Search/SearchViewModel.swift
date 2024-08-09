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
    
    let disposeBag = DisposeBag()
    
    ///Input Observable
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    ///Output Observable
    struct Output {
        let movieList: BehaviorRelay<[Movie]>
        let emptyText: Observable<Void>
        let emptyResult: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let movieList = BehaviorRelay<[Movie]>(value: [])
        
        let searchResult = input.searchButtonTap
            ///Mapping with Search Text
            .withLatestFrom(input.searchText)
            ///Filter Duplicate Text
            .distinctUntilChanged()
            .share(replay: 1)

        searchResult
            ///Rx Network Request
            .flatMap { NetworkManager.shared.rxNetworkRequest(router: Network.search(word: $0, page: 1), type: SearchResult.self) }
            .subscribe { movie in
                movieList.accept(movie.results)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            }
            .disposed(by: disposeBag)
        
        let emptyText = searchResult
            .filter { $0.isEmpty }
            .map { _ in }
        
        let emptyResult = movieList
            .map { !$0.isEmpty }
        
        return Output(movieList: movieList, emptyText: emptyText, emptyResult: emptyResult)
    }
    
    
    
    
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
