//
//  CommontFunction.swift
//  PhotoBrowse
//
//  Created by Jack.Ma on 16/4/28.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

import UIKit

func coverImageFrameToFullScreenFrame(image: UIImage?) -> CGRect {
    guard let image = image else  {
        return CGRectZero
    }
    
    let w:CGFloat = UIScreen.mainScreen().bounds.width
    let h:CGFloat = w * image.size.height / image.size.width
    let x:CGFloat = 0
    let y:CGFloat = (UIScreen.mainScreen().bounds.height - h) * 0.5;
    return CGRect(x: x, y: y, width: w, height: h)
}
