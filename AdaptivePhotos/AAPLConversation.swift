//
//  AAPLConversation.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/21.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import Foundation

class AAPLConversation {
    let name:String
    let photos:[AAPLPhoto]
    
    init(dict:NSDictionary){
        name = dict["name"] as! String
        var photos = [AAPLPhoto]()
        if let photoArray = dict["photos"] as? [NSDictionary]{
            for photoValue in photoArray{
                let photo = AAPLPhoto(dict: photoValue)
                photos.append(photo)
            }
        }
        self.photos = photos
    }
}
