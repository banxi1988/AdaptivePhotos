//
//  AAPLListTableViewController.swift
//  AdaptivePhotos
//
//  Created by Haizhen Lee on 15/8/21.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

struct CellIdentifier {
    static let Conversation = "ConversationCell"
    static let Photo = "PhotoCell"
}

class AAPLListTableViewController: UITableViewController{
    var user:AAPLUser?{
        didSet{
            if isViewLoaded(){
                tableView.reloadData()
            }
        }
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(){
        super.init(style: UITableViewStyle.Plain)
        title = "Conversations"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .Plain, target: self, action: "showProfile:")
        clearsSelectionOnViewWillAppear = false
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.Conversation)
        notificationCenter.addObserver(self, selector: "showDetailTargetDidChange:", name: UIViewControllerShowDetailTargetDidChangeNotification, object: nil)
    }
    
    @IBAction func showProfile(sender:AnyObject) {
       let controller = AAPLProfileViewController()
        controller.user = user
        controller.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "closeProfile:")
        let navVC = UINavigationController(rootViewController: controller)
        navVC.modalPresentationStyle = .FormSheet
        presentViewController(navVC, animated: true, completion: nil)
    }
    
    @IBAction func closeProfile(sender:AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showDetailTargetDidChange(notification:NSNotification){
        for cell in tableView.visibleCells(){
            let tcell = cell as! UITableViewCell
            let indexPath = tableView.indexPathForCell(tcell)
            self.tableView(tableView, willDisplayCell: tcell, forRowAtIndexPath: indexPath!)
        }
    }
    
    // MARK: Table View
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.user!.conversations.count
    }
    
    func conversationForIndexPath(indexPath:NSIndexPath) -> AAPLConversation{
       return self.user!.conversations[indexPath.row]
    }
    
    func shouldShowConversationViewForIndexPath(indexPath:NSIndexPath) -> Bool{
        let conversation = conversationForIndexPath(indexPath)
        return conversation.photos.count > 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(CellIdentifier.Conversation, forIndexPath: indexPath) as! UITableViewCell
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // Whether to show disclosure indicator for this cell
        var pushes = false
        if shouldShowConversationViewForIndexPath(indexPath){
            // If the conversation corresponding to this row has multiple photos
            pushes = aapl_willShowingViewControllerPushWithSender(self)
        }else{
            pushes = aapl_willShowingDetailViewControllerPushWithSender(self)
        }
        
        cell.accessoryType = pushes ? .DisclosureIndicator : .None
        let conversation = conversationForIndexPath(indexPath)
        cell.textLabel?.text = conversation.name
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let conversation = conversationForIndexPath(indexPath)
        if shouldShowConversationViewForIndexPath(indexPath) {
           let controller = AAPLConversationViewController()
            controller.title = conversation.name
            controller.conversation = conversation
            showViewController(controller, sender: self)
        }else{
            let photo = conversation.photos.last
           let controller = AAPLPhotoViewController()
            controller.photo = photo
            controller.title = conversation.name
            showDetailViewController(controller, sender: self)
        }
    }
    
    deinit{
       notificationCenter.removeObserver(self)
    }
    
    
    override func aapl_containsPhoto(photo: AAPLPhoto) -> Bool {
        return true
    }
}





let notificationCenter =  NSNotificationCenter.defaultCenter()