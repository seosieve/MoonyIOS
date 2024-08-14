//
//  MovieInfoViewModel.swift
//  Moony
//
//  Created by 서충원 on 7/14/24.
//

import Foundation

final class MovieInfoViewModel: BaseViewModel {
    
    let movieName: CustomObservable<String?> = CustomObservable(nil)
    let searchMovieResult: CustomObservable<Movie?> = CustomObservable(nil)
    
    let moviePosterArr: CustomObservable<[Poster]> = CustomObservable([Poster]())
    let movieOverview: CustomObservable<String?> = CustomObservable(nil)
    let movieCreditArr: CustomObservable<[Person]> = CustomObservable([Person]())
    
    override func bindData() {
        searchMovieResult.bind { result in
            guard let id = result?.id else { return }
            self.configurePoster(id: id)
            self.configureOverview(id: id)
            self.configureCastArr(id: id)
        }
    }
    
    private func configurePoster(id: Int) {
        NetworkManager.shared.networkRequest(router: Network.poster(id: id), type: PosterResult.self) { result in
            switch result {
            case .success(let success):
                var list: [Poster]
                
                ///backdrops가 하나도 없을 때
                if success.backdrops.isEmpty {
                    ///posters도 하나도 없을 때
                    guard !success.posters.isEmpty else { return }
                    list = success.posters
                } else {
                    list = success.backdrops
                }
                
                ///Infinite Scroll을 위해 첫번째와 마지막 요소 추가
                list.insert(list[list.count-1], at: 0)
                list.append(list[1])
                self.moviePosterArr.value = list
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func configureOverview(id: Int) {
        NetworkManager.shared.networkRequest(router: Network.detail(id: id), type: Movie.self) { result in
            switch result {
            case .success(let success):
                self.movieOverview.value = success.overview
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func configureCastArr(id: Int) {
        NetworkManager.shared.networkRequest(router: Network.credit(id: id), type: CreditsResult.self) { result in
            switch result {
            case .success(let success):
                self.movieCreditArr.value = success.cast
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
