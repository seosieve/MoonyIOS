//
//  HomeView.swift
//  MoviePack
//
//  Created by 서충원 on 7/13/24.
//

import UIKit
import Then
import SnapKit

class HomeView: BaseView {
    
    var previousIndex = 0
    
    let rankLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 290, height: 420)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
    }
    
    lazy var rankCollectionView = UICollectionView(frame: .zero, collectionViewLayout: rankLayout).then {
        let horizontalInset = (UIScreen.main.bounds.width - rankLayout.itemSize.width) / 2
        $0.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        $0.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.identifier)
        $0.contentInsetAdjustmentBehavior = .never
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = false
        $0.delegate = self
    }
    
    let trendLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(width: 100, height: 150)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 20
    }
    
    lazy var trendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: trendLayout).then {
        $0.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
    }
    
    override func configureView() {
        self.backgroundColor = Colors.blackBackground
    }
    
    override func configureSubViews() {
        self.addSubview(rankCollectionView)
        self.addSubview(trendCollectionView)
    }
    
    override func configureConstraints() {
        rankCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(420)
        }
        
        trendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(rankCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = rankCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let layout = rankCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        let offsetX = rankCollectionView.contentOffset.x
        let index = (offsetX + rankCollectionView.contentInset.left) / cellWidth
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
}
