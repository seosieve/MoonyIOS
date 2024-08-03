//
//  TrashViewController.swift
//  MoviePack
//
//  Created by 서충원 on 6/4/24.
//

import UIKit

class TrashViewController: UIViewController {

    var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.text = "고래밥님"
        label.textColor = .white
        return label
    }()
    
    var mainImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "명량")
        return imageView
    }()
    
    var playButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setTitle("재생", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var saveButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 4
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("찜한 리스트", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var subtitleLabel = {
        let label = UILabel()
        label.text = "지금 뜨는 컨텐츠"
        label.textColor = .white
        return label
    }()
    
    var subImageView1 = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "베테랑")
        return imageView
    }()
    
    var subImageView2 = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "부산행")
        return imageView
    }()
    
    var subImageView3 = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "서울의봄")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(mainImageView)
        view.addSubview(playButton)
        view.addSubview(saveButton)
        view.addSubview(subtitleLabel)
        view.addSubview(subImageView1)
        view.addSubview(subImageView2)
        view.addSubview(subImageView3)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(500)
        }
        
        playButton.snp.makeConstraints { make in
            make.leading.bottom.equalTo(mainImageView).inset(20)
            make.trailing.equalTo(view.snp.centerX).inset(10)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(mainImageView).inset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.height.equalTo(40)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(10)
            make.leading.equalTo(mainImageView)
        }
        
        subImageView1.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(20)
            make.height.equalTo(150)
            make.width.equalTo(100)
        }
        
        subImageView2.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(100)
        }
        
        subImageView3.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.trailing.equalTo(-20)
            make.height.equalTo(150)
            make.width.equalTo(100)
        }
    }
}
