//
//  AAPLPhotoViewController.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/22.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

class AAPLPhotoViewController:UIViewController{
    var photo:AAPLPhoto?{
        didSet{
            if oldValue != photo{
                if isViewLoaded(){
                    updatePhoto()
                }
            }
        }
    }
    
    var imageView:UIImageView!
    var overlayView: AAPLOverlayView!
    var ratingControl: AAPLRatingControl!
    
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(imageView)
        
        ratingControl = AAPLRatingControl()
        ratingControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        ratingControl.addTarget(self, action: "changeRating:", forControlEvents: .ValueChanged)
        view.addSubview(ratingControl)
        
        overlayView = AAPLOverlayView()
        overlayView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(overlayView)
        updatePhoto()
       
        
        imageView.pinEdge(UIEdgeInsetsZero)
        ratingControl.pinTrailing(padding: 20)
        overlayView.pinTrailing(padding: 20)
        ratingControl.pinBottom(padding: 20)
        overlayView.pinAboveSibling(ratingControl, withMargin: 0)
        
        var constraints = [NSLayoutConstraint]()
      
        let views : [NSObject:AnyObject] = ["ratingControl": ratingControl,"overlayView": overlayView]
        let constraints1 = NSLayoutConstraint.constraintsWithVisualFormat("|-(>=20)-[ratingControl]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
        constraints += constraints1
        
        let constraints2 = NSLayoutConstraint.constraintsWithVisualFormat("|-(>=20)-[overlayView]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
        constraints += constraints2
       
        for constraint in constraints{
            constraint.priority = 1000 - 1;
        }
        NSLayoutConstraint.activateConstraints(constraints)
        
    }
    
    @IBAction func changeRating(sender:AAPLRatingControl){
        photo?.rating = sender.rating
    }
    
    
    func updatePhoto(){
       imageView.image = photo?.image
        overlayView.text = photo?.comment
        ratingControl.rating = photo?.rating ?? 0
    }
   
    // This method is originally delcared in the AAPLPhotoContents category on UIViewController
    func aapl_containedPhoto() -> AAPLPhoto?{
        return photo
    }
}
