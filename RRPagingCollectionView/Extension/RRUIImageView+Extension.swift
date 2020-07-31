//
//  RRUIImageView+Extension.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 31/07/20.
//  Copyright © 2020 RR. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import RxGesture

extension UIImageView {
        
    func setKingfisherImageView(image: String?, placeholder: String = "placeholder") {
        var path = /*AWSBucket.bucketPath +*/ (image ?? "")
        if let url = image, url.isValidURL() {
            path = url
        }
                
        if placeholder.isEmpty {
            self.kf.indicatorType = .activity
            let indicator = self.kf.indicator?.view as? UIActivityIndicatorView
            //indicator?.style = .whiteLarge
            indicator?.color = .blue
        }
        
        self.kf.setImage(
            with: URL(string: path),
            placeholder: UIImage(named: placeholder),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    func setZoomInZoomOut(disposeBag: DisposeBag) {
        self.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else {return}
                if ((strongSelf.image) != nil) {
                    let configuration = ImageViewerConfiguration { [weak strongSelf] config in
                        guard let strongViewerSelf = strongSelf else {return}
                        config.imageView = strongViewerSelf
                    }
                    let imageViewerController = ImageViewerController(configuration: configuration)
                    UIApplication.topViewController()?.present(imageViewerController, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

