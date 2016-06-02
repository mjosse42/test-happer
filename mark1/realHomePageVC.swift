//
//  realHomePageVC.swift
//  mark1
//
//  Created by Josse on 02/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class realHomePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK : properties
    
    @IBOutlet weak var tab: UITableView!
    @IBOutlet weak var logoProgressBar: KDCircularProgress!
    @IBOutlet weak var mybutton: UIButton!

    var currentCount: Float = 0
    let maxCount: Float = 5
    var selfies: [selfieClass] = []
    
    // MARK : progressBar methods
    
    func newAngle() -> Float {
        return (360 * (self.currentCount / self.maxCount))
    }
    
    // MARK : didLoad/ReceiveMW methods
    
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
        return selfies
    }

    func logoTapped(sender: UIButton) {
        print("TEST")
        if self.currentCount != self.maxCount {
            self.currentCount += 1
            let newAngleValue = newAngle()
            print(newAngleValue)
            self.logoProgressBar.animateToAngle(Double(newAngleValue), duration: 0.5, completion: nil)
        }
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tab.delegate = self
        self.logoProgressBar.angle = 0
        self.selfies = makeSelfie()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(realHomePageVC.logoTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.mybutton.addGestureRecognizer(tapGesture)
        self.view.bringSubviewToFront(logoProgressBar)

        // Close menu at start
        NSNotificationCenter.defaultCenter().postNotificationName("start", object: nil)
        // Catchers for notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homePageVC.open), name: "open", object: nil)
        customNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    func customNavBar() {
        let nav = self.navigationController!.navigationBar
        nav.barTintColor = UIColor.blackColor()
        nav.tintColor = UIColor.whiteColor()
    }

    // MARK : tableViewControl
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selfies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tab.dequeueReusableCellWithIdentifier("realTVCell", forIndexPath: indexPath) as! actuTVCell
        let selfie = self.selfies[indexPath.row]
        cell.photo.image = selfie.getImage()
        cell.nbLike.text = selfie.getLike()
        cell.outfit.text = selfie.getOutfit() as String
        cell.rating.rating = selfie.getRate()
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func toggleMenu(sender: UIBarButtonItem) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }
}
