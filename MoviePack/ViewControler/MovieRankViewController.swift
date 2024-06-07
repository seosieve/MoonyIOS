//
//  MovieRankViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/6/24.
//

import UIKit
import SnapKit
import Alamofire
import Toast

class MovieRankViewController: UIViewController {

    let urlString = APIURL.movieUrl
    var movieArr: [Movie] = [] {
        didSet { movieTableView.reloadData() }
    }
    var yesterdayDate: Int {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = Int(dateFormatter.string(from: yesterday))!
        return date
    }
    
    let movieBackgroundView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Movie")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let dimBackgroundView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var dateTextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "날짜를 입력해주세요", attributes: [.foregroundColor: UIColor.lightGray])
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.delegate = self
        return textField
    }()
    
    lazy var searchButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("SEARCH", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let textFieldDivider = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 1
        return view
    }()
    
    lazy var movieTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieRankTableViewCell.self, forCellReuseIdentifier: MovieRankTableViewCell.identifier)
        tableView.rowHeight = 60
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    func setViews() {
        view.backgroundColor = .white
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        movieRequest(date: yesterdayDate)
    }
    
    func configureSubviews() {
        view.addSubview(movieBackgroundView)
        view.addSubview(dimBackgroundView)
        view.addSubview(searchButton)
        view.addSubview(dateTextField)
        view.addSubview(textFieldDivider)
        view.addSubview(movieTableView)
    }
    
    func configureConstraints() {
        movieBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dimBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().inset(20)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.centerY.equalTo(searchButton)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-20)
            make.height.equalTo(40)
        }
                
        textFieldDivider.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(dateTextField)
            make.height.equalTo(2)
        }
        
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(textFieldDivider).offset(30)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    @objc func dismissKeyboard() {
        dateTextField.endEditing(true)
    }
    
    @objc func searchButtonPressed() {
        searchAction()
    }
    
    @discardableResult func searchAction() -> Bool {
        guard let text = dateTextField.text else { return true }
        
        if let date = Int(text) {
            movieRequest(date: date)
        } else {
            view.makeToast("날짜를 숫자로 입력해주세요.", position: .center)
            dateTextField.text = ""
        }
        
        dateTextField.endEditing(true)
        return true
    }
    
    func movieRequest(date: Int) {
        view.makeToastActivity(.center)
        AF.request(urlString+String(date)).responseDecodable(of: MovieResult.self) { response in
            switch response.result {
            case .success(let value):
                self.configureRequest(value: value)
            case .failure(let error):
                self.view.makeToast("년도와 월, 일을 합쳐 8글자로 작성해주세요.", position: .center)
                self.dateTextField.text = ""
                print(error)
            }
            self.view.hideToastActivity()
        }
    }
    
    func configureRequest(value: MovieResult) {
        let dailyBoxOfficeList = value.boxOfficeResult.dailyBoxOfficeList
        if dailyBoxOfficeList.isEmpty {
            self.view.makeToast("유효한 날짜를 입력해주세요.", position: .center)
            self.dateTextField.text = ""
        } else {
            movieArr = dailyBoxOfficeList
        }
    }
}

//MARK: - UITextFieldDelegate
extension MovieRankViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchAction()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieRankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movieArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieRankTableViewCell.identifier, for: indexPath) as! MovieRankTableViewCell
        cell.configureCell(movie: movie)
        return cell
    }
}
