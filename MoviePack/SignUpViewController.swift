//
//  ViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/4/24.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.text = "MOVIEPACK"
        label.textColor = .cyan
        return label
    }()
    
    var emailTextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 4
        textField.placeholder = "이메일 주소 또는 전화번호"
        textField.textAlignment = .center
        return textField
    }()
    
    var passwordTextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 4
        textField.placeholder = "비밀번호"
        textField.textAlignment = .center
        return textField
    }()
    
    var nicknameTextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 4
        textField.placeholder = "닉네임"
        textField.textAlignment = .center
        return textField
    }()
    
    var locationTextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 4
        textField.placeholder = "위치"
        textField.textAlignment = .center
        return textField
    }()
    
    var recommenderTextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 4
        textField.placeholder = "추천 코드 입력"
        textField.textAlignment = .center
        return textField
    }()
    
    var signUpButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var additionalButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("추가 정보 입력", for: .normal)
        return button
    }()
    
    var toggleSwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.onTintColor = .cyan
        return toggleSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureSubviews()
        setViews()
    }
    
    func configureSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(locationTextField)
        view.addSubview(recommenderTextField)
        view.addSubview(signUpButton)
        view.addSubview(additionalButton)
        view.addSubview(toggleSwitch)
    }
    
    func setViews() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(350)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(350)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(350)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(350)
        }
        
        recommenderTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(350)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(recommenderTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        additionalButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.leading.equalTo(signUpButton)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.trailing.equalTo(signUpButton)
        }
    }

}

