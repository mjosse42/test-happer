//
//  homePageVC.swift
//  mark1
//
//  Created by paul on 31/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class homePageVC: UITableViewController {

    var selfies: [selfieClass] = []
    
    // MARK : code micka
    
    func makeSelfie() -> [selfieClass] {
        var result = NSDictionary()
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/getselfies.php")
        let jsonData = NSData(contentsOfURL: url!)
        do {
            result = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        }
        catch {
            print("Catch-Location:: accueilTVC :: Serialisation JSON")
            EXIT_FAILURE
        }
        let tab = result.valueForKey("selfies") as! NSDictionary
        var selfies: [selfieClass] = []
        for val in tab
        {
            let new: selfieClass = selfieClass(id: val.value["id"] as! NSInteger, own_id: val.value["owner_id"] as! NSInteger, own_un: val.value["owner_un"] as! NSString, url: val.value["url"] as! NSString, rate: val.value["rate"] as! NSInteger, like: val.value["nb_like"] as! NSInteger, outfit: val.value["outfit"] as! NSString)
            selfies += [new]
        }
        selfies.sortInPlace({ $0.getId() > $1.getId() })
        return selfies
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Close menu at start
        NSNotificationCenter.defaultCenter().postNotificationName("start", object: nil)
        // Catchers for notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homePageVC.open), name: "open", object: nil)
        customNavBar()
        self.selfies = makeSelfie()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func customNavBar() {
        let nav = self.navigationController!.navigationBar
        nav.barTintColor = UIColor.blackColor()
        nav.tintColor = UIColor.whiteColor()
    }

    deinit {
        // Clean catcher when instance are destroyed
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // Function called when notifications are catched in viewDidLoad
    func open(notification: NSNotification) {
        let dictionary = notification.object as! NSDictionary
        let destination = dictionary["toOpen"] as! String
        if destination == "partageSegue" || destination == "happlikeSegue" || destination == "dressingSegue" || destination == "produitSegue" || destination == "wishlistSegue" || destination == "amisSegue" || destination == "compteSegue" {
            performSegueWithIdentifier(destination, sender: nil)
        } else {
            print("You tried to perform " + destination)
        }
    }

    @IBAction func toggleMenu(sender: UIBarButtonItem) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.selfies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TVC", forIndexPath: indexPath) as! accueilTVCell
        let selfie = selfies[indexPath.row]
        cell.rating.rating = selfie.getRate()
        cell.outfit.text = selfie.getOutfit() as String
        cell.nbLike.text = String(selfie.getLike())
        cell.imageCell.image = selfie.getImage()
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
