//
//  HomeViewModel.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import Foundation

final class HomeViewModel: BaseViewModel {
    
    let kobisArr: Observable<[KobisRank]> = Observable([KobisRank]())
    let kobisBindingArr: Observable<[Movie?]> = Observable(Array(repeating: nil, count: 10))
    
    let outputKobisDate: Observable<String?> = Observable(nil)
    
    override func bindData() {
        configureKobisDate()
        configureKobisArr()
        
        kobisArr.bind { result in
            guard !result.isEmpty else { return }
            self.configureKobisBindingArr()
        }
    }
    
    private func configureKobisDate() {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let date = formatter.string(from: yesterday)
        outputKobisDate.value = "영화진흥위원회 \(date)일 기준"
    }
    
    private func configureCurrentDate() -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now) else { return String() }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let date = formatter.string(from: yesterday)
        return date
    }
    
    private func configureKobisArr() {
        let date = configureCurrentDate()
        
        NetworkManager.shared.networkRequest(router: Network.kobis(date: date), type: KobisResult.self) { result in
            switch result {
            case .success(let success):
                let list = success.boxOfficeResult.dailyBoxOfficeList
                self.kobisArr.value = list
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func configureKobisBindingArr() {
        kobisArr.value.enumerated().forEach {
            let word = $0.element.movieNm
            let year = String($0.element.openDt.prefix(4))
            let offset = $0.offset
            
            configureSearchResult(word: word, year: year, index: offset)
        }
    }
    
    private func configureSearchResult(word: String, year: String, index: Int) {
        NetworkManager.shared.networkRequest(router: Network.kobisSearch(word: word, year: year), type: MovieResult.self) { result in
            switch result {
            case .success(let success):
                self.kobisBindingArr.value[index] = success.results.first ?? nil
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
