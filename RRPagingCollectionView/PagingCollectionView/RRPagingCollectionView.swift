//
//  RRPagingCollectionView.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 29/07/20.
//  Copyright © 2020 RR. All rights reserved.
//

import UIKit

open class RRPagingCollectionView: UICollectionView {
    
    internal var page: Int = 0
    internal var previousItemCount: Int = 0
    
    open var currentPage: Int {
        get {
            return page
        }
    }
    
    open weak var pagingDelegate: RRPagingCollectionViewDelegate? {
        didSet {
            pagingDelegate?.paginateCtn(self, to: page)
        }
    }
    
    open var isLoading: Bool = false {
        didSet {
            isLoading ? showLoading() : hideLoading()
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        register(RRLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifier)
    }
    
    open func reset() {
        page = 0
        previousItemCount = 0
    }
    
    private func paginate(_ collectionView: RRPagingCollectionView, forIndexAt indexPath: IndexPath) {
        let itemCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: indexPath.section) ?? 0
        guard indexPath.item == itemCount - 1 else { return }
        guard previousItemCount != itemCount else { return }
        page += 1
        previousItemCount = itemCount
        pagingDelegate?.paginateCtn(self, to: page)
    }
    
    private func showLoading() {
        reloadData()
    }
    
    private func hideLoading() {
        reloadData()
        pagingDelegate?.didPaginateCtn?(self, to: page)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath as IndexPath)
            headerView.backgroundColor = UIColor.clear
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath as IndexPath)
            footerView.backgroundColor = UIColor.clear
            return footerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 0, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isLoading {
            return CGSize.init(width: UIScreen.main.bounds.width - 20, height: 50)
        }
        return CGSize.init(width: 0, height: 0)
    }
    
    override open func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        paginate(self, forIndexAt: indexPath)
        return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
}

