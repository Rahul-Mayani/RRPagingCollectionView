//
//  RRPagingCollectionViewDelegate.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 29/07/20.
//  Copyright © 2020 RR. All rights reserved.
//

import UIKit

@objc public protocol RRPagingCollectionViewDelegate {

  @objc optional func didPaginateCtn(_ collectionView: RRPagingCollectionView, to page: Int)
  func paginateCtn(_ collectionView: RRPagingCollectionView, to page: Int)
}
