//
//  HomeView.swift
//  Moony
//
//  Created by 서충원 on 7/13/24.
//

import UIKit
import RxSwift

final class HomeView: BaseView {
    
    var previousIndex = 0
    
    let sortChange = BehaviorSubject<Int>(value: 0)
    
    private lazy var dateOrder = UIAction(title: "오늘", state: .on, handler: updateActionStates)
                                  
    private lazy var titleOrder = UIAction(title: "3년 전 오늘", state: .off, handler: updateActionStates)
    
    private lazy var priorityOrder = UIAction(title: "10년 전 오늘", state: .off, handler: updateActionStates)
    
    private lazy var updateActionStates: (UIAction) -> Void = { action in
        ///ReGenerate Menu
        var sortArr = [self.dateOrder, self.titleOrder, self.priorityOrder]
        sortArr.forEach { $0.state = ($0 == action) ? .on : .off }
        self.filterButtonItem.menu = UIMenu(options: .displayInline, children: sortArr)
        ///Selected Index
        guard let index = sortArr.firstIndex(where: { $0.title == action.title }) else { return }
        self.sortChange.onNext([0, -3, -10][index])
    }
    
    lazy var filterButtonItem = UIBarButtonItem().then {
        let config = UIImage.SymbolConfiguration(weight: .black)
        $0.image = Images.ellipsis?.withConfiguration(config)
        $0.style = .plain
        $0.menu = UIMenu(options: .displayInline, children: [dateOrder, titleOrder, priorityOrder])
    }
    
    private lazy var homeScrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = Colors.blackBackground
    }
    
    private let rankLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 300, height: 550)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = -30
    }
    
    lazy var rankCollectionView = UICollectionView(frame: .zero, collectionViewLayout: rankLayout).then {
        let horizontalInset = (HomeView.screenSize.width - rankLayout.itemSize.width) / 2
        $0.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        $0.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.description())
        $0.contentInsetAdjustmentBehavior = .never
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = false
        $0.delegate = self
    }
    
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = Colors.blackContent
    }
    
    private let progressView = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.progressTintColor = Colors.blackContent
        $0.trackTintColor = Colors.blackInterface
        $0.progress = 0.1
    }
    
    private let trendTitleLabel = UILabel().then {
        $0.text = "Trending For You"
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.textColor = Colors.blackAccent
    }
    
    let movieButton = UIButton().then {
        $0.setTitle("Movie", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.setTitleColor(Colors.blackAccent, for: .normal)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = Colors.blackContent
        $0.layer.borderColor = Colors.blackDescription.cgColor
        $0.layer.borderWidth = 2
        $0.tag = 0
    }
    
    let peopleButton = UIButton().then {
        $0.setTitle("People", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.setTitleColor(Colors.blackDescription, for: .normal)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = Colors.blackInterface
        $0.layer.borderColor = Colors.blackDescription.cgColor
        $0.tag = 1
    }
    
    let tvButton = UIButton().then {
        $0.setTitle("TV", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.setTitleColor(Colors.blackDescription, for: .normal)
        $0.layer.cornerRadius = 17
        $0.backgroundColor = Colors.blackInterface
        $0.layer.borderColor = Colors.blackDescription.cgColor
        $0.tag = 2
    }
    
    private let trendLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 140, height: 240)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
    }
    
    lazy var trendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: trendLayout).then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.description())
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        self.addSubview(homeScrollView)
        homeScrollView.addSubview(contentView)
        contentView.addSubview(rankCollectionView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(progressView)
        contentView.addSubview(trendTitleLabel)
        contentView.addSubview(movieButton)
        contentView.addSubview(peopleButton)
        contentView.addSubview(tvButton)
        contentView.addSubview(trendCollectionView)
    }
    
    override func configureConstraints() {
        homeScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        rankCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(550)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(rankCollectionView.snp.bottom).offset(14)
            make.trailing.equalToSuperview().inset(20)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(100)
        }
        
        trendTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
        }
        
        movieButton.snp.makeConstraints { make in
            make.top.equalTo(trendTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(movieButton.intrinsicContentSize.width + 28)
            make.height.equalTo(34)
        }
        
        peopleButton.snp.makeConstraints { make in
            make.top.equalTo(movieButton)
            make.leading.equalTo(movieButton.snp.trailing).offset(8)
            make.width.equalTo(peopleButton.intrinsicContentSize.width + 28)
            make.height.equalTo(34)
        }
        
        tvButton.snp.makeConstraints { make in
            make.top.equalTo(movieButton)
            make.leading.equalTo(peopleButton.snp.trailing).offset(8)
            make.width.equalTo(tvButton.intrinsicContentSize.width + 28)
            make.height.equalTo(34)
        }
        
        trendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(movieButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(240)
            make.bottom.equalToSuperview().offset(-120)
        }
    }
    
    override func configureNavigationController(_ vc: UIViewController) {
        vc.navigationItem.rightBarButtonItem = filterButtonItem
    }
    
    func trendTypeButtonAnimation(_ index: Int) {
        let buttonArr = [movieButton, peopleButton, tvButton]
        let selectedButton = buttonArr[index]
        
        buttonArr.forEach { button in
            let isSelected = button == selectedButton
            button.setTitleColor(isSelected ? Colors.blackAccent : Colors.blackDescription, for: .normal)
            button.backgroundColor = isSelected ? Colors.blackContent : Colors.blackInterface
            button.layer.borderWidth = isSelected ? 2 : 0
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Names.Noti.rank, object: indexPath.row)
    }
    
    ///Paging & Progress Animation
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = rankCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        let offsetX = targetContentOffset.pointee.x
        let index = (offsetX + scrollView.contentInset.left) / cellWidth
        let roundedIndex = round(index)
        targetContentOffset.pointee = CGPoint(x: roundedIndex * cellWidth - scrollView.contentInset.left, y: 0)
        
        progressAnimation(roundedIndex)
    }
    
    ///Zoom Animation
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let layout = rankCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        let offsetX = rankCollectionView.contentOffset.x
        let index = (offsetX + scrollView.contentInset.left) / cellWidth
        let roundedIndex = round(index)
        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
        if let cell = rankCollectionView.cellForItem(at: indexPath) {
            increaseAnimation(zoomCell: cell)
        }
        
        if Int(roundedIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = rankCollectionView.cellForItem(at: preIndexPath) {
                decreaseAnimation(zoomCell: preCell)
            }
            previousIndex = indexPath.item
        }
    }
    
    func increaseAnimation(zoomCell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            zoomCell.transform = .identity
        }, completion: nil)
    }
    
    func decreaseAnimation(zoomCell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            zoomCell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
    }
    
    func progressAnimation(_ roundedIndex: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.progressView.progress = Float(roundedIndex / 10) + 0.1
            self.layoutIfNeeded()
        }
    }
}
