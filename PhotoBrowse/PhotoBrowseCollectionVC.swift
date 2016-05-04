//
//  PhotoBrowseCollectionVC.swift
//  PhotoBrowse
//
//  Created by Jack.Ma on 16/4/28.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

import UIKit

private let cellMargin: CGFloat = 15.0
/// MARK: - CollectionViewControll Init
class PhotoBrowseCollectionVC: UICollectionViewController {
    
    var items: [ShopItem]!
    var indexPaht: NSIndexPath!
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width + cellMargin, height: UIScreen.mainScreen().bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        self.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// MARK: - CollectionView life circle
private let cellID = "PhotoBrowseCellID"
extension PhotoBrowseCollectionVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.frame = UIScreen.mainScreen().bounds
        collectionView?.frame.size.width = UIScreen.mainScreen().bounds.size.width + cellMargin
        
        collectionView?.pagingEnabled = true
        
        collectionView?.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView?.scrollToItemAtIndexPath(indexPaht!, atScrollPosition: .Left, animated: false)
    }
}

/// MARK: - UICollectionview DataSource&Delegate
extension PhotoBrowseCollectionVC {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return (items?.count)!
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! CollectionViewCell
        
        let item = items![indexPath.item]
        item.showBigImage = true
        cell.item = item
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}








