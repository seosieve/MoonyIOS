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
    var trendMovieArr: [Movie] = [Movie]()
    var trendPersonArr: [Person] = [Person]()
    var trendTVArr: [TV] = [TV]()
    
    let inputTypeButtonTrigger: Observable<Int?> = Observable(nil)
    
    let outputKobisDate: Observable<String?> = Observable(nil)
    
    override func bindData() {
        configureKobisDate()
        configureKobisArr()
        
        configureTrendMovie()
        configureTrendPerson()
        configureTrendTV()
        
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
                print(list)
                self.kobisArr.value = list
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func configureKobisBindingArr() {
        kobisArr.value.enumerated().forEach {
            let word = $0.element.movieNm
            let offset = $0.offset
            configureSearchResult(word: word, index: offset)
        }
    }
    
    private func configureSearchResult(word: String, index: Int) {
        NetworkManager.shared.networkRequest(router: Network.kobisSearch(word: word), type: SearchResult.self) { result in
            switch result {
            case .success(let success):
                print(success.results)
                print("😍😍😍")
                self.kobisBindingArr.value[index] = success.results.first ?? nil
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func configureTrendMovie() {
        NetworkManager.shared.networkRequest(router: .trend(type: "movie"), type: TrendResult<Movie>.self) { result in
            switch result {
            case .success(let success):
                self.trendMovieArr = success.results
                self.inputTypeButtonTrigger.value = 0
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func configureTrendPerson() {
        NetworkManager.shared.networkRequest(router: .trend(type: "person"), type: TrendResult<Person>.self) { result in
            switch result {
            case .success(let success):
                self.trendPersonArr = success.results
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func configureTrendTV() {
        NetworkManager.shared.networkRequest(router: .trend(type: "tv"), type: TrendResult<TV>.self) { result in
            switch result {
            case .success(let success):
                self.trendTVArr = success.results
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
