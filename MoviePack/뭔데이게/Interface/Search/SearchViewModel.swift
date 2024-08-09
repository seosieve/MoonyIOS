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
        let prefetchItem: PublishSubject<Int>
    }
    
    ///Output Observable
    struct Output {
        let searchButtonTap: ControlEvent<Void>
        let movieList: BehaviorRelay<[Movie]>
        let emptyText: Observable<Void>
        let emptyResult: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let movieList = BehaviorRelay<[Movie]>(value: [])
        let totalPage = BehaviorRelay<Int>(value: 0)
        let page = BehaviorRelay<Int>(value: 1)
        
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
                ///Initialize MovieList
                movieList.accept(movie.results)
                ///Initialize Total page
                totalPage.accept(movie.totalPages)
                ///Initialize page
                page.accept(1)
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
        
        input.prefetchItem
            .filter { $0 == movieList.value.count - 1 && page.value < totalPage.value }
            .withLatestFrom(searchResult)
            ///Rx Network Request
            .flatMap { NetworkManager.shared.rxNetworkRequest(router: Network.search(word: $0, page: page.value + 1), type: SearchResult.self) }
            .subscribe { movie in
                ///Add MovieList
                movieList.accept(movieList.value + movie.results)
                ///Add Page
                page.accept(page.value + 1)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            }
            .disposed(by: disposeBag)
        
        return Output(searchButtonTap: input.searchButtonTap, movieList: movieList, emptyText: emptyText, emptyResult: emptyResult)
    }
}
