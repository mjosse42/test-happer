//
//  homePageVC.swift
//  mark1
//
//  Created by paul on 31/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class homePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK : properties

    @IBOutlet weak var viewPB: UIView!
    @IBOutlet weak var progressBar: KDCircularProgress!
    @IBOutlet weak var table: UITableView!
    
    let maxCount: Float = 5
    var currentCount: Float = 0
    var currentID: NSInteger = 0
    var selfies: [selfieClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Close menu at start
        NSNotificationCenter.defaultCenter().postNotificationName("start", object: nil)
        // Catchers for notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homePageVC.open), name: "open", object: nil)
        customNavBar()
        
        // partie micka dessous
        table.delegate = self
        self.progressBar.angle = 0
        self.selfies = makeSelfie()
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

    // MARK : CI DESSOUS CODE A MICKA SI Y A DE LA MERDE C'EST MOI, ----> nan c'est moi c: <----
    
    // MARK : fonctions bouton happie
    
    func tapLogo() {//de la merde
        if self.currentCount != self.maxCount {//de la merde
            self.currentCount += 1//de la merde
            let newAngleValue = newAngle()//de la merde
            print(newAngleValue)//de la merde
            print("ID Select: \(self.currentID)")//de la merde
            self.progressBar.animateToAngle(Double(newAngleValue), duration: 0.5, completion: nil)//de la merde
        }//de la merde
        else {//de la merde
            self.currentCount = 0//de la merde
            self.progressBar.animateFromAngle(self.progressBar.angle, toAngle: 0, duration: 0.5, completion: nil)//de la merde
        }//de la merde
    }//de la merde
    func resetPB() {//de la merde
        self.currentCount = 0//de la merde
        self.progressBar.animateFromAngle(self.progressBar.angle, toAngle: 0, duration: 0.5, completion: nil)//de la merde
    }//de la merde
    
    func newAngle() -> Float {//de la merde
        print("\(self.currentCount) / \(self.maxCount)")//de la merde
        return (360 * (self.currentCount / self.maxCount))//de la merde
    }//de la merde
    
    // MARK : fonctions tableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {//de la merde
        return self.selfies.count//de la merde
    }//de la merde
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {//de la merde
        let cell = self.table.dequeueReusableCellWithIdentifier("HTC", forIndexPath: indexPath) as! homeTableCell//de la merde
        let selfie = self.selfies[indexPath.row]//de la merde
        self.currentID = selfie.getId()//de la merde
        cell.likes.text = selfie.getLike()//de la merde
        cell.outfit.text = selfie.getOutfit() as String//de la merde
        cell.rating.rating = selfie.getRate()//de la merde
        cell.photo.image = selfie.getImage()//de la merde
        return cell//de la merde
    }//de la merde
    
    // MARK : utilitaire
    
    func makeSelfie() -> [selfieClass] {//de la merde
        var result = NSDictionary()//de la merde
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/getselfies.php")//de la merde
        let jsonData = NSData(contentsOfURL: url!)//de la merde
        do {//de la merde
            result = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary//de la merde
        }//de la merde
        catch {//de la merde
            print("Catch-Location:: accueilTVC :: Serialisation JSON")//de la merde
            EXIT_FAILURE//de la merde
        }//de la merde
        let tab = result.valueForKey("selfies") as! NSDictionary//de la merde
        var selfies: [selfieClass] = []//de la merde
        for val in tab//de la merde
        {//de la merde
            let new: selfieClass = selfieClass(id: val.value["id"] as! NSInteger, own_id: val.value["owner_id"] as! NSInteger, own_un: val.value["owner_un"] as! NSString, url: val.value["url"] as! NSString, rate: val.value["rate"] as! NSInteger, like: val.value["nb_like"] as! NSInteger, outfit: val.value["outfit"] as! NSString)//de la merde
            selfies += [new]//de la merde
        }//de la merde
        return selfies//de la merde
    }//de la merde
}