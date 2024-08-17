//
//  HomeViewModel.swift
//  Moony
//
//  Created by 서충원 on 7/13/24.
//

import Foundation

final class HomeViewModel: BaseViewModel {
    
    let kobisArr: CustomObservable<[KobisRank]> = CustomObservable([KobisRank]())
    let kobisBindingArr: CustomObservable<[Movie?]> = CustomObservable(Array(repeating: nil, count: 10))
    var trendMovieArr: [Movie] = [Movie]()
    var trendPersonArr: [Person] = [Person]()
    var trendTVArr: [TV] = [TV]()
    
    let inputTypeButtonTrigger: CustomObservable<Int?> = CustomObservable(nil)
    
    let outputKobisDate: CustomObservable<String?> = CustomObservable(nil)
    
    override func bindData() {
        configureTrendMovie()
        configureTrendPerson()
        configureTrendTV()
        
        kobisArr.bind { result in
            guard !result.isEmpty else { return }
            self.configureKobisBindingArr()
        }
    }
    
    func configureKobisDate(_ index: Int) {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -16, to: .now) else { return }
        guard let targetDate = Calendar.current.date(byAdding: .year, value: index, to: yesterday) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let date = formatter.string(from: targetDate)
        outputKobisDate.value = "영화진흥위원회 \(date)일 기준"
    }
    
    private func configureCurrentDate(_ index: Int) -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -16, to: .now) else { return String() }
        guard let targetDate = Calendar.current.date(byAdding: .year, value: index, to: yesterday) else { return String() }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let date = formatter.string(from: targetDate)
        return date
    }
    
    func configureKobisArr(_ index: Int) {
        let date = configureCurrentDate(index)
        
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
            let offset = $0.offset
            configureSearchResult(word: word, index: offset)
        }
    }
    
    private func configureSearchResult(word: String, index: Int) {
        NetworkManager.shared.networkRequest(router: Network.kobisSearch(word: word), type: SearchResult.self) { result in
            switch result {
            case .success(let success):
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
