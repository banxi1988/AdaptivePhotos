//
//  UIView+PinAutoLayout.swift
//  banxi1988
//  @LastModified 2015/06/12
//  Created by banxi1988 on 15/5/28.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

extension NSLayoutConstraint{
    func priorityLow(){
        priority = 250 // low
    }
    
    func priorityMedium(){
        priority = 500
    }
    
    func priorityHight(){
        priority = 750
    }
    
    func priority(priority:UILayoutPriority){
        self.priority = priority
    }
    
    func priorityRequired(){
        self.priority =  1000 //UILayoutPriorityRequired
    }
    
}

extension UIView{
    
    func pinTop(padding:CGFloat = 15) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        let c = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: superview!, attribute: .Top, multiplier: 1.0, constant: padding)
        superview?.addConstraint(c)
        return c
    }
    
    func pinLeading(padding:CGFloat = 15) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        let c = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: superview!, attribute: .Leading, multiplier: 1.0, constant: padding)
        superview?.addConstraint(c)
        return c
    }
    
    func pinBottom(padding:CGFloat = 15) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        let c = NSLayoutConstraint(item: superview!, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: padding)
        superview?.addConstraint(c)
        return c
    }
    
    func pinTrailing(padding:CGFloat = 15) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        let c = NSLayoutConstraint(item: superview!, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: padding)
        superview?.addConstraint(c)
        return c
    }
    
    func pinVertical(padding:CGFloat =  15){
        pinTop(padding: padding)
        pinBottom(padding: padding)
    }
    
    func pinHorizontal(padding:CGFloat = 15){
        pinLeading(padding: padding)
        pinTrailing(padding: padding)
    }
    
    func pinEdge(padding:UIEdgeInsets){
        pinLeading(padding: padding.left)
        pinTrailing(padding: padding.right)
        pinTop(padding: padding.top)
        pinBottom(padding: padding.bottom)
    }
    
    
    func pinLeadingToSibling(sibling:UIView,withMargin margin:CGFloat = 8) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
        
        let c = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: sibling, attribute: .Trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(c)
        return c
    }
    
    func pinTrailingToSibing(sibling:UIView,withMargin margin:CGFloat = 8) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
        
        let c = NSLayoutConstraint(item: self, attribute:.Trailing , relatedBy: .Equal, toItem: sibling, attribute: .Leading, multiplier: 1.0, constant: -margin)
        superview?.addConstraint(c)
        return c
    }
    
   
    func pinAboveSibling(sibling:UIView,withMargin margin:CGFloat = 8) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
        
        let c = NSLayoutConstraint(item: self, attribute:.Bottom , relatedBy: .Equal, toItem: sibling, attribute: .Top, multiplier: 1.0, constant: -margin)
        superview?.addConstraint(c)
        return c
    }
    
    func pinBelowSibling(sibling:UIView,withMargin margin:CGFloat = 8,priority:UILayoutPriority = 1000) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
        
        let c = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: sibling, attribute: .Bottom, multiplier: 1.0, constant: margin)
        c.priority = priority
        superview?.addConstraint(c)
        return c
    }
   
    func pinCenterXToSibling(sibling:UIView,withOffset offset:CGFloat = 0) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
        
        let c = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: sibling, attribute: .CenterX, multiplier: 1.0, constant: offset)
        superview?.addConstraint(c)
        return c
    }
   
    func pinCenterYToSibling(sibling:UIView,withOffset offset:CGFloat = 0) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
        
        let c = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: sibling, attribute: .CenterY, multiplier: 1.0, constant: offset)
        superview?.addConstraint(c)
        return c
    }
   
    func pinWidthToSibling(sibling:UIView,multiplier:CGFloat = 1.0,constant :CGFloat = 0.0) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
        let c = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: sibling, attribute: .Width, multiplier: multiplier, constant: constant)
        superview?.addConstraint(c)
        return c
    }
    
    func pinHeightToSibling(sibling:UIView,multiplier:CGFloat = 1.0,constant :CGFloat = 0.0) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        assert(superview == sibling.superview, "NOT SIBLING")
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: sibling, attribute: .Height, multiplier: multiplier, constant: constant)
        superview?.addConstraint(c)
        return c
    }
    
    func pinWidth(width:CGFloat) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
        superview?.addConstraint(c)
        return c
    }
    
    func pinWidthGreaterThanOrEqual(width:CGFloat) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
        superview?.addConstraint(c)
        return c
    }
    
    func pinWidthLessThanOrEqual(width:CGFloat) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
        superview?.addConstraint(c)
        return c
    }
    
    func pinHeight(height:CGFloat) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
        superview?.addConstraint(c)
        return c
    }
   
    func pinHeightGreaterThanOrEqual(height:CGFloat) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
        superview?.addConstraint(c)
        return c
    }
    
    func pinHeightLessThanOrEqual(height:CGFloat) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
        superview?.addConstraint(c)
        return c
    }
    
    func pinCenterY(offset:CGFloat=0) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        let c = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: superview!, attribute: .CenterY, multiplier: 1.0, constant: offset)
        superview?.addConstraint(c)
        return c
    }
    
    func pinCenterX(offset:CGFloat=0) -> NSLayoutConstraint{
        assert(superview != nil, "NO SUPERVIEW")
        let c = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: superview!, attribute: .CenterX, multiplier: 1.0, constant: offset)
        superview?.addConstraint(c)
        return c
    }
    
   func pinAspectRatio(aspectRatio:CGFloat=0) -> NSLayoutConstraint{
        let c = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier:aspectRatio, constant: 0)
        self.addConstraint(c)
        return c
    }
    

}