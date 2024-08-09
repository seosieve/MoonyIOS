//
//  NetworkManager.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func networkRequest<T: Decodable>(router: Network, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(router.endPoint, method: router.method, parameters: router.parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    ///Network Request with RxSwift
    func rxNetworkRequest<T: Decodable>(router: Network, type: T.Type) -> Observable<T> {
        ///Create Observable
        let observable = Observable<T>.create { observable in
            ///Mapping Alamofire
            AF.request(router.endPoint, method: router.method, parameters: router.parameters).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observable.onNext(value)
                    observable.onCompleted()
                case .failure(let error):
                    observable.onError(error)
                }
            }
            ///Return Disposable
            return Disposables.create()
        }
        return observable
    }
}
