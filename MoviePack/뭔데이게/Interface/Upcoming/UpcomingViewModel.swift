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
        let sortChange: Observable<Int>
    }
    
    ///Output Observable
    struct Output {
        let movieList: BehaviorRelay<[Movie]>
    }
    
    func transform(input: Input) -> Output {
        
        let movieList = BehaviorRelay<[Movie]>(value: [])
        
        Observable.just(getDateString())
            ///Mapping with Router
            .map { Network.upcoming(minDate: $0.minDate, maxDate: $0.maxDate) }
            ///Rx Network Request
            .flatMap { NetworkManager.shared.rxNetworkRequest(router: $0, type: SearchResult.self) }
            .subscribe { movie in
                ///Sort By Popularity
                let sortedMovie = movie.results.sorted { $0.releaseDate ?? "" < $1.releaseDate ?? "" }
                ///Initialize MovieList
                movieList.accept(sortedMovie)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            }
            .disposed(by: disposeBag)
        
        input.sortChange
            .subscribe(onNext:{ value in
                if value == 0 {
                    let sortedMovie = movieList.value.sorted { $0.releaseDate ?? "" < $1.releaseDate ?? "" }
                    movieList.accept(sortedMovie)
                } else {
                    let sortedMovie = movieList.value.sorted { $0.popularity ?? 0 > $1.popularity ?? 0 }
                    movieList.accept(sortedMovie)
                }
            })
            .disposed(by: disposeBag)
        
        
        return Output(movieList: movieList)
    }
    
    func getDateString() -> (minDate: String, maxDate: String) {
        let minDate = Date()
        let maxDate = Calendar.current.date(byAdding: .year, value: 1, to: minDate) ?? Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let minDateString = formatter.string(from: minDate)
        let maxDateString = formatter.string(from: maxDate)
        
        return (minDateString, maxDateString)
    }
}

