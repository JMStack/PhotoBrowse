//
//  CollectionViewCell.swift
//  PhotoBrowse
//
//  Created by Jack.Ma on 16/4/28.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = UIImageView()
    
    var item: ShopItem? {
        didSet {
            guard let item = item else {
                return
            }
            var url:NSURL?
            if item.showBigImage {
                url = NSURL(string: item.z_pic_url)
                guard let _ = url else {
                    return
                }
                var placeholderImage  = SDImageCache.sharedImageCache().imageFromMemoryCacheForKey(item.q_pic_url)
                if placeholderImage == nil {
                    placeholderImage = UIImage(named: "empty_picture")
                }
                imageView.sd_setImageWithURL(url!, placeholderImage: placeholderImage) { (image, erro, _, _) in
                    self.layoutIfNeeded()
                }
            } else {
                url = NSURL(string: item.q_pic_url)
                guard let _ = url else {
                    return
                }
                imageView.sd_setImageWithURL(url!, placeholderImage: UIImage(named: "empty_picture")) { (image, erro, _, _) in
                    self.layoutIfNeeded()
                }
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let image = imageView.image else {
            return
        }
        guard let item = item else {
            return
        }
        let w:CGFloat = item.showBigImage ? UIScreen.mainScreen().bounds.width : frame.width
        let h:CGFloat = w * image.size.height / image.size.width
        let x:CGFloat = 0
        let y:CGFloat = (self.frame.size.height - h) * 0.5;
        self.imageView.frame = CGRect(x: x, y: y, width: w, height: h)
    }
}
