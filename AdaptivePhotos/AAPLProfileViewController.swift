//
//  AAPLProfileViewController.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/21.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

class AAPLProfileViewController: UIViewController{
    var user:AAPLUser?{
        didSet{
            if isViewLoaded(){
                updateUser()
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Profile"
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    var conversationsLabel: UILabel!
    var photosLabel: UILabel!
    var constraints = [NSLayoutConstraint]()
    
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(imageView)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(nameLabel)
        
        conversationsLabel = UILabel()
        conversationsLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        conversationsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(conversationsLabel)
        
        photosLabel = UILabel()
        photosLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        photosLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(photosLabel)
        
        self.view = view
        updateUser()
        updateConstraintsForTraitCollection(traitCollection)
        
    }
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        coordinator.animateAlongsideTransition({ (ctx) -> Void in
            self.updateConstraintsForTraitCollection(newCollection)
            self.view.setNeedsLayout()
        }, completion: nil)
    }
    
    func updateUser(){
        nameLabel.text = nameText
        conversationsLabel.text = conversationsText
        photosLabel.text = photosText
        imageView.image = user?.lastPhoto?.image
    }
    
    var nameText:String?{
        return user?.name
    }
    
    var conversationsText:String?{
        return "\(user!.conversations.count)"
    }
    
    var photosText:String{
        let count = user!.conversations.reduce(0){ $0  + $1.photos.count }
        return "\(count) photos"
    }
    
    func updateConstraintsForTraitCollection(traitCollection:UITraitCollection){
       
        let views: [NSObject:AnyObject] = [
            "topLayoutGuide": self.topLayoutGuide,
            "imageView":imageView,
            "nameLabel":nameLabel,
            "conversationsLabel": conversationsLabel,
            "photosLabel": photosLabel
        ]
        var newConstraints = [NSLayoutConstraint]()
        
        if traitCollection.verticalSizeClass == .Compact{
           let constraints1 = NSLayoutConstraint.constraintsWithVisualFormat("|[imageView]-[nameLabel]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints1
           let constraints2 = NSLayoutConstraint.constraintsWithVisualFormat("|[imageView]-[conversationsLabel]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints2
           let constraints3 = NSLayoutConstraint.constraintsWithVisualFormat("|[imageView]-[photosLabel]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints3
           let constraints4 = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide]-[nameLabel]-[conversationsLabel]-[photosLabel]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints4
           let constraints5 = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide][imageView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints5
            let constraint = NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.5, constant: 0.0)
            newConstraints.append(constraint)
        }else{
           
            let constraints1 = NSLayoutConstraint.constraintsWithVisualFormat("|[imageView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints1
            let constraints2 = NSLayoutConstraint.constraintsWithVisualFormat("|-[nameLabel]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints2
            let constraints3 = NSLayoutConstraint.constraintsWithVisualFormat("|-[conversationsLabel]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints3
            let constraints4 = NSLayoutConstraint.constraintsWithVisualFormat("|-[photosLabel]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints4
            let constraints5 = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[nameLabel]-[conversationsLabel]-[photosLabel]-20-[imageView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views) as! [NSLayoutConstraint]
            newConstraints += constraints5
        }
        
        if constraints.count > 0 {
            NSLayoutConstraint.deactivateConstraints(constraints)
        }
        constraints = newConstraints
        NSLayoutConstraint.activateConstraints(constraints)
    }
}