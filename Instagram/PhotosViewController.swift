//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Michael Gonzales on 3/7/16.
//  Copyright © 2016 mkgo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func post(sender: AnyObject) {
        performSegueWithIdentifier("postSegue", sender: sender)
        
    }
    @IBAction func logout2(sender: AnyObject) {
        // PFUser.currentUser() will now be nil
        PFUser.logOut()
        let LoginViewController = storyboard!.instantiateViewControllerWithIdentifier("LoginViewController");
        self.presentViewController(LoginViewController, animated:true, completion:nil);
        print("Logged Out!")

    }

    @IBOutlet weak var photoTable: UITableView!
    var photos: [PFObject]?
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        photoTable.insertSubview(refreshControl, atIndex: 0)
        
        photoTable.dataSource = self
        photoTable.delegate = self
        self.parseAPICall()
        photoTable.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logout(sender: AnyObject) {
        // PFUser.currentUser() will now be nil
        PFUser.logOut()
        let LoginViewController = storyboard!.instantiateViewControllerWithIdentifier("LoginViewController");
        self.presentViewController(LoginViewController, animated:true, completion:nil);
        print("Logged Out!")
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photos?.count ?? 0
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostCell
        cell.selectionStyle = .None
        
        let photo = photos![indexPath.row]
        cell.instagramPost = photo
        
        
        
        return cell
        
    }
    
    
    func parseAPICall() {
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                
                print("photos pulled")
                self.photos = posts
                self.photoTable.reloadData()
            } else {
                
                print (error?.localizedDescription)
            }
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.photoTable.reloadData()
        self.parseAPICall()
        refreshControl.endRefreshing()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
