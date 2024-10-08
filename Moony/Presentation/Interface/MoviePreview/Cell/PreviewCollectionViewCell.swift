//
//  PreviewCollectionViewCell.swift
//  Moony
//
//  Created by 서충원 on 8/11/24.
//

import UIKit
import YoutubePlayer_in_WKWebView

final class PreviewCollectionViewCell: BaseCollectionViewCell {
    
    let previewVideoView = WKYTPlayerView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.blackInterface.cgColor
        $0.backgroundColor = Colors.blackInterface
    }
    
    let skeletonView = UIView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.blackInterface.cgColor
        $0.backgroundColor = Colors.blackInterface
        $0.isSkeletonable = true
        $0.showAnimatedGradientSkeleton()
    }
    
    override func configureView() {
        contentView.backgroundColor = Colors.blackBackground
        previewVideoView.delegate = self
    }
    
    override func configureSubViews() {
        contentView.addSubview(previewVideoView)
        contentView.addSubview(skeletonView)
    }
    
    override func configureConstraints() {
        previewVideoView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        skeletonView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func configureCell(key: String) {
        DispatchQueue.main.async {
            self.previewVideoView.load(withVideoId: key)
        }
    }
}

//MARK: - WKYTPlayerViewDelegate
extension PreviewCollectionViewCell: WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        skeletonView.stopSkeletonAnimation()
        skeletonView.hideSkeleton()
        skeletonView.isHidden = true
    }
    
    func playerView(_ playerView: WKYTPlayerView, receivedError error: WKYTPlayerError) {
        print("receivedError")
    }
}


