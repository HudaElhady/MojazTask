//
//  ServerManagerCalls.swift
//  Task
//
//  Created by MIS on 5/4/18.
//  Copyright © 2018 Huda Elhady. All rights reserved.
//

import UIKit

extension ServerManager {
    static var photosResource = Resource<[PhotoItem]>(url: "\(MainURL)", httpmethod: .get)
    { (json) -> [PhotoItem]? in
        
        //print(json)
        var photoList = [PhotoItem]()
        if let jsonObj = json as? [NSDictionary]
        {
            for item in jsonObj
            {
                
                let content = PhotoItem(fromDictionary: item as! [String : Any])
                photoList.append(content)
           
            }
        }
        return photoList
    }
    
    func getPhotosList(pageNumber:Int, pageSize:Int)
    {
        ServerManager.photosResource.url = "\(MainURL)?_start=\(pageNumber)&_limit=\(pageSize)"
        httpConnect(resource: ServerManager.photosResource, paramters: nil, authentication: nil, complation:
            { (json, data) in
                if let photos = json
                {
                    self.didFinish?(photos as AnyObject)
                }
        })
        { (error, msg) in
            self.didFinishWithError?(error, msg)
        }
    }
    
}
