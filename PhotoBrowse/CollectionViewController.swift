//
//  CollectionViewController.swift
//  PhotoBrowse
//
//  Created by Jack.Ma on 16/4/27.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

import UIKit

private  let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    private      let cellMargin: CGFloat = 20.0
    internal     var shopitems = [ShopItem]()
    private lazy var modalDelegate: ModalAnimationDelegate = ModalAnimationDelegate()
}

/// MARK: - view life circle
extension CollectionViewController {
    
    override func loadView() {
        super.loadView()
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: cellMargin, bottom: cellMargin, right: cellMargin)
    }
    /// MARK: - collectionview life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionViewFlowLayout()
        // Register cell classes
        self.collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
       loadMoreHomePageData(0)
    }
}
/// MARK: - collectionview cell data work
extension CollectionViewController {
    func loadMoreHomePageData(offset: Int) {
        HttpManager.manager.loadPhotoData(offset) { (result, error) in
            guard let result = result as? [[String : AnyObject]] else {
                return
            }
            for resultDict in result {
                let item = ShopItem(dict: resultDict)
                self.shopitems.append(item)
            }
            self.collectionView?.reloadData()
        }
    }
}

/// MARK: - colletionview flowlayout
extension CollectionViewController {
    func setUpCollectionViewFlowLayout() -> Void {
        let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        guard let layout = flowLayout else {
            return
        }
        let width = (UIScreen.mainScreen().bounds.width - 5 * cellMargin) / 4.0
        layout.itemSize = CGSize(width: width, height: width)
        layout.scrollDirection = .Vertical
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return shopitems.count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? CollectionViewCell
        
        let item = shopitems[indexPath.item];
        item.showBigImage = false
        cell?.item = item
        
        if indexPath.item == shopitems.count - 1 {
            loadMoreHomePageData(shopitems.count)
        }
        
        return cell!
    }
}

// MARK: UICollectionView delegate
extension CollectionViewController: UIViewControllerTransitioningDelegate {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let photoVC = PhotoBrowseCollectionVC()
        photoVC.indexPaht = indexPath
        photoVC.items = shopitems
        photoVC.transitioningDelegate = modalDelegate
        photoVC.modalPresentationStyle = .Custom
        presentViewController(photoVC, animated: true, completion: nil)
    }
}




















