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
    func rxNetworkRequest<T: Decodable>(router: Network, type: T.Type) -> Single<T> {
        ///Create Observable
        let observable = Single<T>.create { single in
            ///Mapping Alamofire
            AF.request(router.endPoint, method: router.method, parameters: router.parameters).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    single(.success(value))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            ///Return Disposable
            return Disposables.create()
        }
        return observable
    }
}
