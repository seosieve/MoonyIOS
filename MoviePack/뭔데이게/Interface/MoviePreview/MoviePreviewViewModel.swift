//
//  MoviePreviewViewModel.swift
//  MoviePack
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
        let posterList: BehaviorRelay<[Poster]>
    }
    
    func transform(input: Input) -> Output {
        
        let movieId = input.movieId ?? 0
        
        let videoList = BehaviorRelay<[Video]>(value: [])
        let posterList = BehaviorRelay<[Poster]>(value: [])
        
        //Configure Video
        NetworkManager.shared.rxNetworkRequest(router: Network.video(id: movieId), type: VideoResult.self)
            .subscribe { value in
                videoList.accept(value.results)
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
        
        return Output(videoList: videoList, posterList: posterList)
    }
}
