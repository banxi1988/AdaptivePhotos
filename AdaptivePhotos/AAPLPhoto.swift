//
//  AAPLPhoto.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/21.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

class AAPLPhoto:NSObject{
    var imageName:String?
    var comment:String?
    var rating:Int  = 0
    
    init(dict:NSDictionary){
        imageName = dict["imageName"] as! String
        comment = dict["comment"] as? String
        rating = dict["rating"] as? Int ?? 0
    }
    
    var image:UIImage?{
        let imgPath =  NSBundle.mainBundle().pathForResource(imageName, ofType: "jpg")
        return UIImage(named: imgPath!)
    }
}

extension AAPLPhoto:Equatable{
    
}

func ==(left:AAPLPhoto,right:AAPLPhoto) -> Bool{
    return left.imageName == right.imageName
}