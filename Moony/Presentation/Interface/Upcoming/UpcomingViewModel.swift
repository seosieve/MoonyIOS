//
//  UpcomingViewModel.swift
//  Moony
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
        let genreSelect: ControlEvent<IndexPath>
        let genreDeselect: ControlEvent<IndexPath>
    }
    
    ///Output Observable
    struct Output {
        let movieList: BehaviorRelay<[Movie]>
        let genreSelect: ControlEvent<IndexPath>
        let genreDeselect: ControlEvent<IndexPath>
    }
    
    func transform(input: Input) -> Output {
        
        let movieList = BehaviorRelay<[Movie]>(value: [])
        let sortOrder = BehaviorRelay<Int>(value: 0)
        
        //Initial Network Request
        NetworkManager.shared.rxNetworkRequest(router: getRouter(genre: ""), type: SearchResult.self)
            .subscribe(with: self) { owner, value in
                ///Filter
                let filteredMovie = owner.filterMovie(movie: value.results)
                ///Sort
                let sortedMovie = owner.sortMovie(with: sortOrder.value, movie: filteredMovie)
                ///Initialize MovieList
                movieList.accept(sortedMovie)
            } onFailure: { _, error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        input.sortChange
            .subscribe(with: self, onNext: { owner, value in
                ///Update SortOrder
                sortOrder.accept(value)
                ///Sort
                let movie = owner.sortMovie(with: value, movie: movieList.value)
                movieList.accept(movie)
            })
            .disposed(by: disposeBag)
        
        input.genreSelect
            .distinctUntilChanged()
            .map { Names.Genre.allCases[$0.item].rawValue }
            ///Mapping with Router
            .map { self.getRouter(genre: $0) }
            ///Rx Network Request
            .flatMap { NetworkManager.shared.rxNetworkRequest(router: $0, type: SearchResult.self) }
            .subscribe(with: self, onNext: { owner, value in
                ///Filter
                let filteredMovie = owner.filterMovie(movie: value.results)
                ///Sort
                let sortedMovie = owner.sortMovie(with: sortOrder.value, movie: filteredMovie)
                ///Change MovieList
                movieList.accept(sortedMovie)
            }, onError: { owner, error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        return Output(movieList: movieList, genreSelect: input.genreSelect, genreDeselect: input.genreDeselect)
    }
    
    //Get Network Router
    private func getRouter(genre: String) -> Network {
        let dateString = getDateString()
        
        return Network.upcoming(minDate: dateString.minDate, maxDate: dateString.maxDate, genre: genre)
    }
    
    //Return Current & 1 year later Date
    private func getDateString() -> (minDate: String, maxDate: String) {
        let minDate = Date()
        let maxDate = Calendar.current.date(byAdding: .year, value: 1, to: minDate) ?? Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let minDateString = formatter.string(from: minDate)
        let maxDateString = formatter.string(from: maxDate)
        
        return (minDateString, maxDateString)
    }
    
    //Filter Movie
    private func filterMovie(movie: [Movie]) -> [Movie] {
        ///Filter that have no image
        return movie.filter { !$0.imageUrl.isEmpty }
    }
    
    //Sort Movie
    private func sortMovie(with order: Int, movie: [Movie]) -> [Movie] {
        ///Sort By Order
        return movie.sorted { order == 0 ? ($0.releaseDate < $1.releaseDate) : ($0.popularity > $1.popularity) }
    }
}

