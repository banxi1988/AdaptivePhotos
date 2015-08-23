//
//  AAPLUser.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/21.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import Foundation

class AAPLUser {
    let name:String
    let conversations:[AAPLConversation]
    let lastPhoto:AAPLPhoto?
    
    init(dict:NSDictionary){
        name = dict["name"] as? String ?? ""
        var list = [AAPLConversation]()
        if let conversationValues = dict["conversations"] as? [NSDictionary]{
            for conversationValue in conversationValues{
                let conversation = AAPLConversation(dict: conversationValue)
                list.append(conversation)
            }
        }
        conversations = list
        if let photoValue = dict["lastPhoto"] as? [String:AnyObject]{
            lastPhoto = AAPLPhoto(dict: photoValue)
        }else{
            lastPhoto = nil
        }
    }
}
