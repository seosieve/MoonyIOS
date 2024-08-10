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
            .subscribe(with: self, onNext: { owner, value in
                ///Sort By Popularity
                let sortedMovie = owner.sortMovie(with: 0, movie: value.results)
                ///Initialize MovieList
                movieList.accept(sortedMovie)
            }, onError: { owner, error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        input.sortChange
            .subscribe(with: self, onNext: { owner, value in
                ///Sort By Order
                let sortedMovie = owner.sortMovie(with: value, movie: movieList.value)
                movieList.accept(sortedMovie)
            })
            .disposed(by: disposeBag)
        
        
        return Output(movieList: movieList)
    }
    
    //Return Current & 1 year later Date
    func getDateString() -> (minDate: String, maxDate: String) {
        let minDate = Date()
        let maxDate = Calendar.current.date(byAdding: .year, value: 1, to: minDate) ?? Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let minDateString = formatter.string(from: minDate)
        let maxDateString = formatter.string(from: maxDate)
        
        return (minDateString, maxDateString)
    }
    
    //Sort Movie by Order
    func sortMovie(with order: Int, movie: [Movie]) -> [Movie] {
        let sortedMovie: [Movie]
        
        if order == 0 {
            sortedMovie = movie.sorted { $0.releaseDate < $1.releaseDate }
        } else {
            sortedMovie = movie.sorted { $0.popularity > $1.popularity }
        }
        
        return sortedMovie
    }
}

