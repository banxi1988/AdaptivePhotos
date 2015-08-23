//
//  AAPLOverlayView.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/22.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

class AAPLOverlayView:UIView {
    var text:String?{
        get{
            return label.text
        }
        set{
            label.text = newValue
            invalidateIntrinsicContentSize()
        }
    }
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
   
    func commonInit(){
        let effect = UIBlurEffect(style: .Light)
        let backgroundView = UIVisualEffectView(effect: effect)
        backgroundView.backgroundColor = UIColor(white: 0.7, alpha: 0.3)
        
        backgroundView.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(backgroundView)
        backgroundView.pinEdge(UIEdgeInsetsZero)
        
        label  = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        addSubview(label)
        label.pinCenterX()
        label.pinCenterY()
       
        notificationCenter.addObserver(self, selector: "contentSizeCategoryDidChange:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
        
    deinit{
        notificationCenter.removeObserver(self)
    }
    
    func contentSizeCategoryDidChange(notification:NSNotification){
        label.font  = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
    override func intrinsicContentSize() -> CGSize {
        var size = label.intrinsicContentSize()
        // Add a horizontal margin whose size on our horizontal size class
        if traitCollection.horizontalSizeClass == .Compact{
            size.width +=  CGFloat(8.0)
        }else{
            size.width += CGFloat(40.0)
        }
        
        if traitCollection.verticalSizeClass == .Compact{
            size.height += CGFloat(8.0)
        }else{
            size.height += CGFloat(40.0)
        }
        return size
    }
    
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass
            || traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass{
                invalidateIntrinsicContentSize()
        }
    }
}
