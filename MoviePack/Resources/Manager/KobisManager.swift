//
//  KobisManager.swift
//  MoviePack
//
//  Created by 서충원 on 7/14/24.
//

import Foundation
import Alamofire

struct KobisManager {
    
    static let shared = KobisManager()
    
    private init() { }
    
    let urlString = APIURL.kobisUrl
    
    func movieRequest(date: Int, completionHandler: @escaping (KobisResult?, Error?) -> Void) {
        
        let parameters: Parameters = ["targetDt": String(date)]
        
        AF.request(urlString, parameters: parameters).responseDecodable(of: KobisResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
