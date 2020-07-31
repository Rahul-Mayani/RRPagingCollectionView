//
//  UserCell.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 31/07/20.
//  Copyright © 2020 RR. All rights reserved.
//


import UIKit
import RxSwift

class UserCell: UICollectionViewCell {
    // MARK: - IBOutlet -
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    // MARK: - Variable -
    var disposeBag = DisposeBag()
    
    var user: UserModel? = nil {
        didSet {
            userImageView.setKingfisherImageView(image: user?.avatar ?? "", placeholder: "")
            userImageView.setZoomInZoomOut(disposeBag: disposeBag)
            
            userNameLabel.text = user?.fullName() ?? ""
            userEmailLabel.text = user?.email ?? ""
        }
    }
    
    // MARK: - Cell Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

