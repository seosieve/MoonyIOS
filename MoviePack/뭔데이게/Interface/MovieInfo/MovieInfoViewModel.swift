//
//  MovieInfoViewModel.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import Foundation

final class MovieInfoViewModel: BaseViewModel {
    
    let movieName: Observable<String?> = Observable(nil)
    let searchMovieResult: Observable<Movie?> = Observable(nil)
    let posterResultArr: Observable<[Poster]> = Observable([Poster]())
    let movieOverview: Observable<String?> = Observable(nil)
    
    override func bindData() {
        searchMovieResult.bind { result in
            guard let id = result?.id else { return }
            self.configurePoster(id: id)
            self.configureOverview(id: id)
        }
    }
    
    private func configurePoster(id: Int) {
        NetworkManager.shared.networkRequest(router: Network.poster(id: id), type: PosterResult.self) { result in
            switch result {
            case .success(let success):
                ///backdrops가 하나도 없을 때
                if success.backdrops.isEmpty {
                    ///posters도 하나도 없을 때
                    guard !success.posters.isEmpty else { return }
                    var list = success.posters
                    list.insert(list[list.count-1], at: 0)
                    list.append(list[1])
                    self.posterResultArr.value = list
                } else {
                    var list = success.backdrops
                    list.insert(list[list.count-1], at: 0)
                    list.append(list[1])
                    self.posterResultArr.value = list
                }
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
}
