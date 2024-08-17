//
//  MoviePreviewViewModel.swift
//  Moony
//
//  Created by 서충원 on 7/15/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MoviePreviewViewModel: BaseViewModel, ViewModelType {
    
    let disposeBag = DisposeBag()
    
    ///Input Observable
    struct Input {
        let movieId: Int?
    }
    
    ///Output Observable
    struct Output {
        let videoList: BehaviorRelay<[Video]>
        let tagline: BehaviorRelay<String>
        let posterList: BehaviorRelay<[Poster]>
        let similarList: BehaviorRelay<[Movie]>
    }
    
    func transform(input: Input) -> Output {
        
        let movieId = input.movieId ?? 0
        
        let videoList = BehaviorRelay<[Video]>(value: [])
        let tagline = BehaviorRelay<String>(value: "")
        let posterList = BehaviorRelay<[Poster]>(value: [])
        let similarList = BehaviorRelay<[Movie]>(value: [])
        
        //Configure Video
        NetworkManager.shared.rxNetworkRequest(router: Network.video(id: movieId), type: VideoResult.self)
            .subscribe { value in
                videoList.accept(value.results)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        //Configure Tagline
        NetworkManager.shared.rxNetworkRequest(router: Network.detail(id: movieId), type: Movie.self)
            .subscribe { value in
                tagline.accept(value.tagline ?? "")
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        //Configure Poster
        NetworkManager.shared.rxNetworkRequest(router: Network.poster(id: movieId), type: PosterResult.self)
            .subscribe { value in
                posterList.accept(value.posters)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        //Configure Similar
        NetworkManager.shared.rxNetworkRequest(router: Network.similar(id: movieId, page: 1), type: SearchResult.self)
            .subscribe { value in
                similarList.accept(value.results)
            } onFailure: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        return Output(videoList: videoList, tagline: tagline, posterList: posterList, similarList: similarList)
    }
}
