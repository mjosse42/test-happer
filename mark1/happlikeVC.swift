//
//  happlikeVC.swift
//  mark1
//
//  Created by paul on 01/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class happlikeVC: UIViewController {

    // MARK : - image centrale
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var currentSelfie: UIImageView!
    var selfies: [selfieClass] = []
    var index: Int = 0
    
    
    // MARK : - elements du canvas
    
    @IBOutlet weak var notifView: UIView!
    @IBOutlet weak var ratingControl: FloatRatingView!
    @IBOutlet weak var happieView: UIView!
    @IBOutlet weak var happiePB: circularPB!
    @IBOutlet weak var botView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var nbHappies: UILabel!
    @IBOutlet weak var ratingView: UIControl!
    @IBOutlet weak var modoView: UIView!
    @IBOutlet weak var uploadView: UIView!
    
    
    // MARK : - userDefault
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modoView.layer.cornerRadius = 25
        self.uploadView.layer.cornerRadius = 25
        self.ratingView.addTarget(self, action: #selector(self.touchDown), forControlEvents: .TouchDown)
        self.ratingView.userInteractionEnabled = true
        self.selfies = makeSelfie()
        self.currentSelfie.image = selfies[self.index].getImage()
        self.logo.transform = CGAffineTransformMakeRotation(-1.57)
        self.happiePB.addSubview(logo)
        self.happiePB.progress = 0
        self.defaults.setFloat(0.0, forKey: "currentCount")
        self.defaults.setFloat(5.0, forKey: "maxCount")
        self.botView.addSubview(self.happieView)
        self.ratingControl.addSubview(self.happieView)
        self.topView.addSubview(self.happieView)
        self.centerView.addSubview(self.happieView)
        self.botView.bringSubviewToFront(self.ratingView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        moveUpHappie()
        self.happiePB.progress = 0.5
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("scroller", object: nil)
    }
    
    // MARK : - animation
    
    func moveUpHappie() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.happieView.frame = CGRectMake(
                self.happieView.frame.origin.x,
                self.happieView.frame.origin.y - 400,
                self.happieView.frame.size.width,
                self.happieView.frame.size.height)
        })
    }
    
    // MARK : - recuperation des selfies
    
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
    func touchDown() {
        print("RELEASED")
    }
    
    // MARK: - jauge circulaire
    
    /*if self.currentCount != self.maxCount {
     self.currentCount += 1
     let newAngleValue = newAngle()
     self.progressBar.animateToAngle(Double(newAngleValue), duration: 0.5, completion: nil)
     }
     else {
     self.currentCount = 0
     self.progressBar.animateFromAngle(self.progressBar.angle, toAngle: 0, duration: 0.5, completion: nil)
     }
     
        func resetPB() {
            self.currentCount = 0
            self.progressBar.animateFromAngle(self.progressBar.angle, toAngle: 0, duration: 0.5, completion: nil)
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
