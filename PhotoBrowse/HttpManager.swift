//
//  HttpManager.swift
//  PhotoBrowse
//
//  Created by Jack.Ma on 16/4/27.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

import UIKit
import AFNetworking

enum RequstType {
    case GET,POST
}

class HttpManager: NSObject {
    static let manager = HttpManager()
    private lazy var sessionManager: AFHTTPSessionManager = {
       let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        return manager
    }()
    
    
    func request(method: RequstType, url: String, params: [String : AnyObject], result: (success: AnyObject?, error: NSError?) -> ()) {
        
        switch method {
        case .GET:
            sessionManager.GET(url, parameters: params, progress: nil, success: { (_, responseObject) in
                result(success: responseObject, error: nil)
                
                }, failure: { (_, error) in
                result(success: nil, error: error)
                    
            })
        case .POST:
            sessionManager.POST(url, parameters: params, progress: nil, success: { (_, responseObject) in
                result(success: responseObject, error: nil)
                }, failure: { (_, error) in
                    result(success: nil, error: error)
            })
        }
    }
    
}
extension HttpManager {
    func loadPhotoData(offset: Int, finished : (result: AnyObject?, error: NSError?) -> ()) -> Void {
        let url = "http://mobapi.meilishuo.com/2.0/twitter/popular.json"
        let params = ["offset" : "\(offset)","limit" : "30", "access_token" : "b92e0c6fd3ca919d3e7547d446d9a8c2"]
        
        request(.GET, url: url, params: params) { (success, error) in
            if let error = error {
                finished(result: nil, error: error)
                return
            }
            
            guard let success = success as? [String : AnyObject] else {
                finished(result: nil, error: NSError(domain: "error", code: 10011, userInfo: nil))
                return
            }
            
            finished(result: success["data"], error: nil)
        }
        
    }
}