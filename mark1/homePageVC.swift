//
//  homePageVC.swift
//  mark1
//
//  Created by paul on 31/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class homePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK : properties

    @IBOutlet weak var viewPB: UIView!
    @IBOutlet weak var table: UITableView!

    var defaults = NSUserDefaults.standardUserDefaults()
    var selfies: [selfieClass] = []

    func checkLoggued() {
        let log = defaults.boolForKey("loggued")
        if (log == false) {
            FBSDKAccessToken.setCurrentAccessToken(nil)
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewControllerWithIdentifier("mainPage") as! mainPageVC
            self.presentViewController(vc, animated: true, completion: nil)
        }
        print("loggued est à '\(log)'")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLoggued()
        NSNotificationCenter.defaultCenter().postNotificationName("start", object: nil)
        
        // Catchers for notification
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homePageVC.open), name: "open", object: nil)
        customNavBar()
        
        // partie micka dessous
        
        table.delegate = self
        // self.selfies = makeSelfie()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapLogo))
        self.viewPB.userInteractionEnabled = true
        self.viewPB.addGestureRecognizer(tapGesture)
        self.view.bringSubviewToFront(self.viewPB)
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
        if destination == "partageSegue" || destination == "happlikeSegue" || destination == "dressingSegue" || destination == "produitSegue" || destination == "wishlistSegue" || destination == "coeurSegue" || destination == "amisSegue" || destination == "compteSegue" {
            performSegueWithIdentifier(destination, sender: nil)
        } else {
            print("You tried to perform " + destination)
        }
    }

    @IBAction func toggleMenu(sender: UIBarButtonItem) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }

    // MARK : CI DESSOUS CODE A MICKA SI Y A DE LA MERDE C'EST MOI
    
    // MARK : fonctions bouton happie
    
    func tapLogo() {
        NSNotificationCenter.defaultCenter().postNotificationName("push", object: nil)
        self.performSegueWithIdentifier("happlikeSegue", sender: self)
    }
    
    // MARK : fonctions tableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCellWithIdentifier("HTC", forIndexPath: indexPath) as! homeTableCell
        //let selfie = self.selfies[indexPath.row]
        cell.likes.text = "42" //selfie.getLike()
        cell.outfit.text = "#OOTD"//selfie.getOutfit() as String
        cell.rating.rating = 3//selfie.getRate() as Float
        //cell.photo.image = //selfie.getImage()
        return cell
    }
    
    // MARK : utilitaire
    
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
            let new: selfieClass = selfieClass(id: val.value["id"] as! NSInteger, own_id: val.value["owner_id"] as! NSInteger, own_un: val.value["owner_un"] as! NSString, url: val.value["url"] as! NSString, rate: val.value["rate"] as! Float, like: val.value["nb_like"] as! NSInteger, outfit: val.value["outfit"] as! NSString)
            selfies += [new]
        }
        return selfies
    }
}