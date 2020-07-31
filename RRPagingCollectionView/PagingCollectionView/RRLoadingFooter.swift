//
//  RRLoadingFooter.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 29/07/20.
//  Copyright © 2020 RR. All rights reserved.
//

import UIKit

let footerIdentifier = "RRLoadingFooter"

class RRLoadingFooter: UICollectionReusableView {

    private var indicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       self.backgroundColor = UIColor.clear
       indicator = UIActivityIndicatorView()
       indicator.color = UIColor.blue
       indicator.translatesAutoresizingMaskIntoConstraints = false
       indicator.startAnimating()
       addSubview(indicator)
       centerIndicator()
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func centerIndicator() {
        let xCenterConstraint = NSLayoutConstraint(
            item: self, attribute: .centerX, relatedBy: .equal,
            toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0
        )
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(
            item: self, attribute: .centerY, relatedBy: .equal,
            toItem: indicator, attribute: .centerY, multiplier: 1, constant: 0
        )
        self.addConstraint(yCenterConstraint)
    }
}
