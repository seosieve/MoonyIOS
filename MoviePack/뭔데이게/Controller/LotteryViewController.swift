//
//  LotteryViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/5/24.
//

import UIKit
import SnapKit

class LotteryViewController: UIViewController {
    
    var latestRound: Int {
        Int(floor(((Date().timeIntervalSince1970-1039186800) / 604800) + 1))
    }
    lazy var roundArr = Array(1...latestRound)

    lazy var numberTextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.inputView = numberPickerView
        textField.inputAccessoryView = numberToolBar
        return textField
    }()
    
    lazy var numberPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var numberToolBar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(dismissPickerView))
        toolBar.tintColor = .darkGray
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        return toolBar
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
        label.text = ""
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
        label.text = ""
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
        label.text = ""
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
        label.text = ""
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
        label.text = ""
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
        label.text = ""
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
        label.text = ""
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
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    func setViews() {
        view.backgroundColor = .white
        numberTextField.text = String(latestRound)
        numberPickerView.selectRow(latestRound-1, inComponent: 0, animated: true)
        configureLotto(round: String(latestRound))
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
    
    func configureConstraints() {
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
    
    @objc func dismissPickerView() {
        self.view.endEditing(true)
    }
    
    func configureLotto(round: String) {
        LottoManager.shared.lotteryRequest(round: round) { lotto, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                guard let lotto = lotto else { return }
                self.configureUI(value: lotto)
            }
        }
    }
    
    func configureUI(value: Lotto) {
        print(value)
        dateLabel.text = value.drawDateString
        roundLabel.text = value.drawNoString
        let numberArr = [value.drwtNo1, value.drwtNo2, value.drwtNo3, value.drwtNo4, value.drwtNo5, value.drwtNo6, value.bnusNo]
        let numberLabelArr = [ball1, ball2, ball3, ball4, ball5, ball6, bonusBall]
        zip(numberLabelArr, numberArr).forEach { $0.text = String($1) }
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
        let round = String(roundArr[row])
        numberTextField.text = round
        configureLotto(round: round)
    }
}
