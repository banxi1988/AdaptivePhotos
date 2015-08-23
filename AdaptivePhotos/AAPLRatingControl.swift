//
//  AAPLRatingControl.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/22.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

let AAPLRatingControlMinimumRating = 0
let AAPLRatingControlMaximumRating = 4

class AAPLRatingControl: UIControl {
    var rating = 0{
        didSet{
            if oldValue != rating{
               updateImageViews()
            }
        }
    }
    
    internal var  backgroundView : UIVisualEffectView!
    internal var imageViews:[UIImageView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        rating = AAPLRatingControlMinimumRating
        let effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        backgroundView = UIVisualEffectView(effect: effect)
        backgroundView?.contentView.backgroundColor = UIColor(white: 0.7, alpha: 0.3)
        addSubview(backgroundView)
        var imageViews = [UIImageView]()
        for rating in AAPLRatingControlMinimumRating...AAPLRatingControlMaximumRating{
            let imageView = UIImageView()
            imageView.userInteractionEnabled = true
            imageView.image = UIImage(named: "ratingInactive")
            imageView.highlightedImage = UIImage(named: "ratingActive")
            imageView.accessibilityLabel = "\(rating + 1) stars"
            addSubview(imageView)
            imageViews.append(imageView)
        }
        self.imageViews  = imageViews
        updateImageViews()
        
        // Setup constraints
        backgroundView.setTranslatesAutoresizingMaskIntoConstraints(false)
        backgroundView.pinEdge(UIEdgeInsetsZero)
        var lastImageView:UIImageView?
        for imageView in imageViews{
            imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
            imageView.pinVertical(padding: 4)
            imageView.pinAspectRatio(aspectRatio: 1)
            if let lastImageView = lastImageView{
                imageView.pinWidthToSibling(lastImageView, multiplier: 1.0, constant: 0)
                imageView.pinLeadingToSibling(lastImageView, withMargin: 0)
            }else{
               imageView.pinLeading(padding: 4)
            }
            lastImageView = imageView
        }
        lastImageView?.pinTrailing(padding: 4)
        
        
    }

    
    func updateImageViews(){
        for (index,imageView) in   enumerate(imageViews){
           imageView.highlighted = (index + AAPLRatingControlMinimumRating) <= rating
        }
    }
    
    
    // MARK: Touches
    func updateRatingWithTouches(touches:Set<NSObject> ,withEvent event:UIEvent){
       let touch = touches.first as! UITouch
        let position = touch.locationInView(self)
        let touchedView = hitTest(position, withEvent: event)
        for (index,imageView) in enumerate(imageViews){
            if imageView == touchedView{
                self.rating = AAPLRatingControlMinimumRating + index
                break
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        updateRatingWithTouches(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        updateRatingWithTouches(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        // There's no need to handle this touch event for this control
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // There's no need to handle this touch event for this control
        
    }
}

