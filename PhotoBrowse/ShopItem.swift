//
//  ShopItems.swift
//  PhotoBrowse
//
//  Created by Jack.Ma on 16/4/27.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

import UIKit

class ShopItem: NSObject {
    var q_pic_url : String = ""
    var z_pic_url : String = ""
    var showBigImage : Bool = false;
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
