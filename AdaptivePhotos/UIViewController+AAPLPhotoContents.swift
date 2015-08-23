//
//  UIViewController+AAPLPhotoContents.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/23.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

extension UIViewController{
   
    var aapl_containedPhoto:AAPLPhoto?{
        return nil
    }
    
    func aapl_containsPhoto(photo:AAPLPhoto) -> Bool{
        return false
    }
    
    
    func aapl_currentVisibleDetailPhotoWithSender(sender:AnyObject) -> AAPLPhoto?{
        let target = targetViewControllerForAction("aapl_currentVisibleDetailPhotoWithSender:", sender: sender)
        if let target = target{
            return target.aapl_currentVisibleDetailPhotoWithSender(sender)
        }else{
            return nil
        }
    }
    
}

extension UISplitViewController{
    override func aapl_currentVisibleDetailPhotoWithSender(sender: AnyObject) -> AAPLPhoto? {
        if self.collapsed{
            // If we're collapsed, we con't have a detail
            return nil
        }else{
            let controller = viewControllers.last as? UIViewController
            return controller?.aapl_containedPhoto
        }
    }
    
}
