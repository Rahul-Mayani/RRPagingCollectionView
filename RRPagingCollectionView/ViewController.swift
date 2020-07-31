//
//  ViewController.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 29/07/20.
//  Copyright © 2020 RR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlet -
    @IBOutlet weak var userCollectionView: RRPagingCollectionView!
    
    // MARK: - Variable -
    private var userData: RRDataModel?
    private var userArray: [UserModel] = []
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userCollectionView.pagingDelegate = self
        getUserList()
    }
}

// MARK: - PagingCollectionViewDelegate -
extension ViewController: RRPagingCollectionViewDelegate {
    
    func paginateCtn(_ collectionView: RRPagingCollectionView, to page: Int) {
        if !userCollectionView.isLoading && userData?.total ?? 0 > self.userArray.count {
            userCollectionView.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.getUserList()
            }
        }
    }
}

// MARK: - CollectionView -
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userCell: UserCell = collectionView.dequeueReusableCell(for: indexPath)
        let user = userArray[indexPath.item]
        userCell.user = user
        return userCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width - 20, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return userCollectionView.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return userCollectionView.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return userCollectionView.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForFooterInSection: section)
    }
}

// MARK: - API -
extension ViewController {
    
    fileprivate func getUserList() {
        
        RRAPIManager.shared.getUserList(userCollectionView.page + 1) { [weak self] (data, error) in
            guard let self = self else { return }
            
            if error == nil {
                OperationQueue.main.addOperation({
                    self.userData = data
                    self.userArray = self.userArray + (self.userData?.data ?? [])
                    self.userCollectionView.reloadData()
                    self.userCollectionView.isLoading = false
                })
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
}
