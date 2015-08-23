//
//  UIViewController+AAPLViewControllerShowing.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/23.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit


extension UIViewController/* AAPLViewControllerShowing*/{
    func aapl_willShowingViewControllerPushWithSender(sender:AnyObject) -> Bool{
        let target = targetViewControllerForAction("aapl_willShowingViewControllerPushWithSender:", sender: sender)
        if let target = target{
            return target.aapl_willShowingViewControllerPushWithSender(sender)
        }else{
            return false
        }
    }
    
    func aapl_willShowingDetailViewControllerPushWithSender(sender:AnyObject) -> Bool{
        targetForAction("", withSender: "")
        let target = targetViewControllerForAction("aapl_willShowingDetailViewControllerPushWithSender:", sender: sender)
        if let target = target{
            return target.aapl_willShowingDetailViewControllerPushWithSender(sender)
        }else{
            return false
        }
    }
    
}

extension UINavigationController /*AAPLViewControllerShowing*/{
    override func aapl_willShowingViewControllerPushWithSender(sender: AnyObject) -> Bool {
        return true
    }
}

extension UISplitViewController /*AAPLViewControllerShowing*/{
    override func aapl_willShowingViewControllerPushWithSender(sender: AnyObject) -> Bool {
        // Split View Controllers never push for showViewController
        return false
    }
    
    override func aapl_willShowingDetailViewControllerPushWithSender(sender: AnyObject) -> Bool {
        if collapsed{
            // If we're collapsed, re-ask this question as showViewController: to our primary view controller
            let target = viewControllers.last!
            return target.aapl_willShowingViewControllerPushWithSender(sender)
        }else{
            // Otherwise ,we don't push for showDetailViewController
            return false
        }
    }
}