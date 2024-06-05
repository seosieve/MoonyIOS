//
//  LotteryViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/5/24.
//

import UIKit

class LotteryViewController: UIViewController {
    
    let roundArr = [11,12,13,14,15]
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1122"

    lazy var numberTextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.inputView = numberPickerView
        return textField
    }()
    
    lazy var numberPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        return pickerView
    }()
    
    let announcementLabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.text = "2020-05-30 추첨"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let divider = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let roundStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let roundLabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.text = "913회"
        label.font = .boldSystemFont(ofSize: 21)
        return label
    }()
    
    let roundSubLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "당첨결과"
        label.font = .boldSystemFont(ofSize: 21)
        return label
    }()
    
    let ballStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    let ball1 = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "6"
        return label
    }()
    
    let ball2 = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.backgroundColor = .systemCyan
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "6"
        return label
    }()
    
    let ball3 = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.backgroundColor = .systemCyan
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "6"
        return label
    }()
    
    let ball4 = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.backgroundColor = .systemPink
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "6"
        return label
    }()
    
    let ball5 = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.backgroundColor = .systemPink
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "37"
        return label
    }()
    
    let ball6 = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.backgroundColor = .systemGray
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "37"
        return label
    }()
    
    let plusBall = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .black
        label.text = "+"
        return label
    }()
    
    let bonusBall = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.backgroundColor = .systemGray
        label.layer.cornerRadius = 18
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "40"
        return label
    }()
    
    let bonusLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "보너스"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSubviews()
        setViews()
    }
    
    func configureSubviews() {
        view.addSubview(numberTextField)
        view.addSubview(announcementLabel)
        view.addSubview(dateLabel)
        view.addSubview(divider)
        view.addSubview(roundStackView)
        roundStackView.addArrangedSubview(roundLabel)
        roundStackView.addArrangedSubview(roundSubLabel)
        view.addSubview(ballStackView)
        ballStackView.addArrangedSubview(ball1)
        ballStackView.addArrangedSubview(ball2)
        ballStackView.addArrangedSubview(ball3)
        ballStackView.addArrangedSubview(ball4)
        ballStackView.addArrangedSubview(ball5)
        ballStackView.addArrangedSubview(ball6)
        ballStackView.addArrangedSubview(plusBall)
        ballStackView.addArrangedSubview(bonusBall)
        view.addSubview(bonusLabel)
    }
    
    func setViews() {
        numberTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
        
        announcementLabel.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(announcementLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(announcementLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        roundStackView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }

        ballStackView.snp.makeConstraints { make in
            make.top.equalTo(roundStackView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        
        ballStackView.arrangedSubviews.forEach { view in
            let label = view as! UILabel
            label.snp.makeConstraints { make in
                make.width.equalTo(label.snp.height)
            }
        }
        
        bonusLabel.snp.makeConstraints { make in
            make.top.equalTo(ballStackView.snp.bottom).offset(8)
            make.centerX.equalTo(ballStackView.arrangedSubviews.last!.snp.centerX)
        }
    }
}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roundArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(roundArr[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function)
    }
}
