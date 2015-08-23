//
//  AAPLEmptyViewController.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/22.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

class AAPLEmptyViewController: UIViewController{
   
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.text = "No Conversation Selected"
        label.textColor = UIColor(white: 0.0, alpha: 0.4)
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        view.addSubview(label)
        
        
        label.pinCenterX()
        label.pinCenterY()
        self.view = view
    }
    
}
