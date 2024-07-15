//
//  OverViewTableViewCell.swift
//  MoviePack
//
//  Created by 서충원 on 6/10/24.
//

import UIKit
import SnapKit

class OverViewTableViewCell: UITableViewCell {
    
    var isExtended = false {
        didSet { toggleLabelLines() }
    }
    
    let overViewLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    lazy var detailButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .medium)
        let paperclip = UIImage(systemName: "chevron.down", withConfiguration: config)
        button.setImage(paperclip, for: .normal)
        button.tintColor = .systemGray2
        button.addTarget(self, action: #selector(detailButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionAnimation()
    }
    
    func setViews() {
        backgroundColor = Colors.blackBackground
    }
    
    func configureSubviews() {
        contentView.addSubview(overViewLabel)
        contentView.addSubview(detailButton)
    }
    
    func configureConstraints() {
        overViewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    @objc func detailButtonPressed() {
        isExtended.toggle()
    }
    
    private func toggleLabelLines() {
        UIView.animate(withDuration: 0.3) {
            let up = UIImage(systemName: "chevron.up")
            let down = UIImage(systemName: "chevron.down")
            self.detailButton.setImage(self.isExtended ? up : down, for: .normal)
            self.overViewLabel.numberOfLines = self.isExtended ? 0 : 2
            self.layoutIfNeeded()
            self.invalidateIntrinsicContentSize()
        }
    }
}
