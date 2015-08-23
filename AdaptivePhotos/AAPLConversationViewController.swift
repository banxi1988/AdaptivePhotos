//
//  AAPLConversationViewController.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/22.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

class AAPLConversationViewController:UITableViewController{
    var conversation:AAPLConversation?{
        didSet{
            
        }
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(){
        super.init(style: .Plain)
    }
    
    override convenience init(style: UITableViewStyle) {
        self.init()
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
   
    deinit{
        notificationCenter.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.Photo)
        notificationCenter.addObserver(self, selector: "showDetailTargetDidChange:", name: UIViewControllerShowDetailTargetDidChangeNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPaths = tableView.indexPathsForVisibleRows() as? [NSIndexPath]{
            for indexPath in indexPaths{
               let indexPathPushes = aapl_willShowingDetailViewControllerPushWithSender(self)
                if indexPathPushes{
                    tableView.deselectRowAtIndexPath(indexPath, animated: animated)
                }
            }
        }
        
        let visiblePhoto = aapl_willShowingDetailViewControllerPushWithSender(self)
        if visiblePhoto{
            if let indexPaths = tableView.indexPathsForVisibleRows() as? [NSIndexPath]{
                for indexPath in indexPaths{
                    let photo = photoForIndexPath(indexPath)
                }
            }
        }
    }
    
    func containsPhoto(photo:AAPLPhoto) -> Bool{
        return contains(conversation!.photos, photo)
    }
    
    func showDetailTargetDidChange(notification:NSNotification){
        if let cells = tableView.visibleCells() as? [UITableViewCell]{
            for cell in cells{
                let indexPath = tableView.indexPathForCell(cell)
                tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath!)
            }
        }
    }
    
    // MARK: Table View
    
    func photoForIndexPath(indexPath:NSIndexPath) -> AAPLPhoto{
        return conversation!.photos[indexPath.row]
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation!.photos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(CellIdentifier.Photo, forIndexPath: indexPath) as! UITableViewCell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let pushes = aapl_willShowingDetailViewControllerPushWithSender(self)
        cell.accessoryType = pushes ? .DisclosureIndicator: .None
        let photo = photoForIndexPath(indexPath)
        cell.textLabel?.text = photo.comment
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let photo = photoForIndexPath(indexPath)
        let controller = AAPLPhotoViewController()
        controller.photo = photo
        let photoNumber = indexPath.row + 1
        let photoCount = conversation!.photos.count
        controller.title = "\(photoNumber) of \(photoCount)"
        
        // Show the photo as the detail (if possible)
        showDetailViewController(controller, sender: self)
    }
   
    override func aapl_containsPhoto(photo: AAPLPhoto) -> Bool {
        return containsPhoto(photo)
    }
}
