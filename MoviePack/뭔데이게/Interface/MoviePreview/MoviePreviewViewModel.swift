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
    
    var movieId: Int?
    
    ///Input Observable
    struct Input {
        
    }
    
    ///Output Observable
    struct Output {
        let videoList: BehaviorRelay<[Video]>
    }
    
    func transform(input: Input) -> Output {
        
        let videoList = BehaviorRelay<[Video]>(value: [])
        
        Observable.just(movieId)
            .compactMap { $0 }
            ///Mapping with Router
            .map { Network.video(id: $0) }
            ///Rx Network Request
            .flatMap { NetworkManager.shared.rxNetworkRequest(router: $0, type: VideoResult.self) }
            .subscribe(with: self, onNext: { owner, value in
                ///Initialize VideoList
                videoList.accept(value.results)
            }, onError: { owner, error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        return Output(videoList: videoList)
    }
}
