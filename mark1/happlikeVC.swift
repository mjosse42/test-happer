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
    
    let colorTab: [UIColor] = [UIColor.darkGrayColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.lightGrayColor(), UIColor.blueColor()]
    
    @IBOutlet weak var rankPB: UIProgressView!
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
    @IBOutlet weak var nbCredits: UILabel!
    
    
    // MARK : - userDefault
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var ammount: CGFloat = 0.3
    var nbh = 5
    var nbc = 10
    
    @IBOutlet weak var likedIcon: UIImageView!
    @IBOutlet weak var likedView: UIView!
    @IBOutlet weak var LnbLike: UILabel!
    
    var liked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nbc = defaults.integerForKey("credits")
        
        updateHappie()
        updateCredits()
        
        let tapg = UITapGestureRecognizer(target: self, action: #selector(happlikeVC.like))
        self.likedView.addGestureRecognizer(tapg)
        
        self.likedIcon.image = UIImage(named: "emptyHeart")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(happlikeVC.endRating), name: "ratingOK", object: nil)
        
        initPB()
        self.modoView.layer.cornerRadius = 25
        self.uploadView.layer.cornerRadius = 25
        //initImage()
        self.defaults.setFloat(0.0, forKey: "currentCount")
        self.defaults.setFloat(5.0, forKey: "maxCount")
        self.defaults.setInteger(5, forKey: "happieCount")
        self.botView.addSubview(self.happieView)
        self.ratingControl.addSubview(self.happieView)
        self.topView.addSubview(self.happieView)
        self.centerView.addSubview(self.happieView)
    }
    
    //MARK: - initView
    
    func initImage() {
        self.selfies = makeSelfie()
        self.currentSelfie.image = selfies[self.index].getImage()
        self.LnbLike.text = "\(selfies[self.index].getLike())"
    }
    
    func initPB() {
        self.rankPB.progress = Float(defaults.integerForKey("exp")) / 100
        self.rankPB.progressTintColor = self.colorTab[defaults.integerForKey("rank")]
        self.rankPB.trackTintColor = UIColor.blackColor()
        self.logo.transform = CGAffineTransformMakeRotation(-1.57)
        self.happiePB.addSubview(logo)
        self.happiePB.progress = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        moveUpHappie()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("scroller", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        moveDownHappie()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK : - animation
    
    func moveDownHappie() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.happieView.frame = CGRectMake(
                self.happieView.frame.origin.x,
                self.happieView.frame.origin.y + 400,
                self.happieView.frame.size.width,
                self.happieView.frame.size.height)
        })
    }
    
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
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/getToRate.php")
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
    
    func updateHappie() {
        self.nbHappies.text = " \(nbh) happies "
    }
    func updateCredits() {
        self.nbCredits.text = " \(nbc) crédits "
    }
    
    func like() {
        if self.liked == true {
            self.liked = false
            self.likedIcon.image = UIImage(named: "emptyHeart")
        }
        else {
            self.liked = true
            self.likedIcon.image = UIImage(named: "fullHeart")
        }
    }
    
    func endRating() {
        
        // avant tout ça on enregistre
        self.index += 1
        self.liked = false
        self.likedIcon.image = UIImage(named: "emptyHeart")
        if (self.ratingControl.rating > 0) {
//                self.currentSelfie.image = self.selfies [self.index].getImage()
                self.ratingControl.rating = 0
                self.happiePB.progress += self.ammount
                if (self.happiePB.progress >= 1) {
                    self.happiePB.progress = 0
                    self.nbh -= 1
                    self.nbc += 20
                    updateHappie()
                    updateCredits()
                    self.rankPB.setProgress(self.rankPB.progress + 0.3, animated: true)
                    if (self.rankPB.progress >= 1) {
                        self.rankPB.progressTintColor = self.colorTab[defaults.integerForKey("rank") + 1]
                        self.rankPB.progress = 0
                    }
                }
            
        }
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
