# MOONY - 취향들이 새겨져 만들어지는 무늬 <img src="https://github.com/user-attachments/assets/163776a3-e7d6-4d79-bbd7-c77566a7151a" width="30" height="30">
> A Pattern Carved With Tastes
<br>
<br>

<div align="center">
  <img src="https://github.com/user-attachments/assets/163776a3-e7d6-4d79-bbd7-c77566a7151a" width="150" height="150">
  <br>
  <br>
  <img src="https://img.shields.io/badge/Swift-v5.10-red?logo=swift"/>
  <img src="https://img.shields.io/badge/Xcode-v15.4-blue?logo=Xcode"/>
  <img src="https://img.shields.io/badge/iOS-16.0+-black?logo=apple"/>  
  <br>
  <br>
</div>

<div align="center">
  <br>
  <img src="https://github.com/user-attachments/assets/1428da37-1578-4c61-bdfe-429699503c09" width="19%"> <img src="https://github.com/user-attachments/assets/32d90ab9-8fa9-477c-9d3e-efdfbf4e238b" width="19%"> <img src="https://github.com/user-attachments/assets/7ec3943c-6b67-4ade-b270-795a9fb1b9dc" width="19%"> <img src="https://github.com/user-attachments/assets/294f7829-fd26-4ca1-ba73-e5b7e1b13938" width="19%"> <img src="https://github.com/user-attachments/assets/4a262d08-bef0-490d-bf49-736337bfe756" width="19%">
</div>
<br>

## 프로젝트 소개
`🎥 정말 감명깊게 본 영화는 무늬처럼 우리 몸안에 남더라고`
> 실시간 영화 순위를 살펴보고, 궁금했던 영화를 검색, 메모와 함께 기억하고싶은 영화들을 소중하게 저장할 수 있는 앱
<br>

## 프로젝트 주요 기능
- 날마다의 **영화 순위, 관객 수**를 살펴볼 수 있는 메인화면
- **줄거리와 등장인물 정보** 등을 확인할 수 있는 상세화면
- Youtube와 연동되어 제공되는 **영화 예고편**
- **장르별 개봉 영화 탐색**, 개봉일 순, 관객 기대 순위 순 정렬 기능
- TMDB 데이터베이스를 이용한 영화 **검색 / 정렬 / 저장** 기능
- 원하는 영화를 메모와 함께 나의 **폴더별 무늬 저장소**에 저장 가능
<br>

## 프로젝트 개발 환경
- 개발 인원
  - iOS개발 1명
- 개발 기간
  - 2024.07 - 2024.08 (1개월)
- iOS 최소 버전
  - iOS 16.0+
<br>

## 프로젝트 기술 스택
- **활용기술 및 키워드**
  - **iOS** : swift 5.10, xcode 15.4, UIKit
  - **Network** : RxSwift, Alamofire
  - **UI** : CodeBaseUI, Snapkit, Then, Hero

- **라이브러리**

라이브러리 | 사용 목적 | Version
:---------:|:----------:|:---------:
Kingfisher | 이미지 처리 | 7.0
SkeletonView | 로딩 이미지 처리 | 1.31
Realm | 앱 내 파일 저장소 | 10.52.1
<br>

## 프로젝트 아키텍처
<div align="center">
  <img src="https://github.com/user-attachments/assets/8e858f4b-d725-481c-9dd6-03d216643dd4">
</div>
<br>

> Input / Output + MVVM Architecture
- RxSwift Input / Output Pattern을 통한 양방향 데이터 바인딩으로 프로젝트 데이터 흐름 일원화
- Router Pattern을 통한 반복되는 네트워크 작업 추상화, RxSwift Single Traits를 통한 에러 핸들링
- Generic 형식의 Base Class 상속과 Protocol 채택을 통한 프로젝트 구조의 명시적 정의
<br>

## 트러블 슈팅
### 1. 네트워크 통신에서 onError를 받게 되면 Control Event의 전체 Stream이 끊기는 문제
> onNext, onComplete가 아닌 onError를 받게 되면 FlatMap에서 Mapping한 함수일지라도 Stream 전체가 끊겨버린다.
<div align="center">
  <img src="https://github.com/user-attachments/assets/1888cb99-4065-4428-a152-634a5149cebb">
  <img src="https://github.com/user-attachments/assets/9b216392-be9b-465b-9fec-bfcda12ba44b">
</div>
<br>

- Request와 Decodable 리턴 형식만 다른 반복되는 네트워크 통신을 추상화하기 위해, Alamofire를 **Router Pattern**과 함께 적용
- RxSwift의 **Single Traits**를 사용하여 Observable의 이벤트 방출, 완료를 단순화하여 처리하려 하였으나, Error Case시에 전체 Stream까지 **모두 종료되는 이슈**가 발생
- **Result 형태를 맵핑하는 Single**을 반환값으로 설정하고, Error Case 또한 Single에서가 아닌 Result 형태에서 처리하는 형태로 문제 해결
> Network Manager
```swift
//Network Request with RxSwift
func rxNetworkRequest<T: Decodable>(router: Network, type: T.Type) -> Single<T> {
    //Create Observable
    let observable = Single<T>.create { single in
        //Mapping Alamofire
        AF.request(router.endPoint, method: router.method, parameters: router.parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                single(.success(value))
            case .failure(let error):
                single(.failure(error))
            }
        }
        //Return Disposable
        return Disposables.create()
    }
    return observable
}
```
> ViewModel
```swift
button.rx.tap
    .throttle(.seconds(1), scheduler: MainScheduler.instance)
    .distinctUntilChanged()
    .flatMapLatest { NetworkManager.shared.networkRequest(router: Network.poster(id: id), type: PosterResult.self) }
    .subscribe(onNext: { value in
        switch value {
        case .success(let poster):
            print(poster)
        case .failure(let error):
            print(error)
        }
    }, onError: { error in
        print(error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })
    .disposed(by: disposeBag)
```
