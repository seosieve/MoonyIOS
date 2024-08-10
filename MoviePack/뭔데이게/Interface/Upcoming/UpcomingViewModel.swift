//
//  UpcomingViewModel.swift
//  MoviePack
//
//  Created by 서충원 on 8/10/24.
//

import Foundation
import RxSwift
import RxCocoa

final class UpcomingViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    ///Input Observable
    struct Input {
        let trigger: Observable<Void>
    }
    
    ///Output Observable
    struct Output {
        let movieList: BehaviorRelay<[Movie]>
    }
    
    func transform(input: Input) -> Output {
        
        let movieList = BehaviorRelay<[Movie]>(value: [])
        
        input.trigger
            ///Rx Network Request
            .flatMap { NetworkManager.shared.rxNetworkRequest(router: Network.upcoming(date: "2024-08-10"), type: SearchResult.self) }
            .subscribe { movie in
                ///Initialize MovieList
                movieList.accept(movie.results)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            }
            .disposed(by: disposeBag)
        
        
        return Output(movieList: movieList)
    }
}

