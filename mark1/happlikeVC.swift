//
//  happlikeVC.swift
//  mark1
//
//  Created by paul on 01/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class happlikeVC: UIViewController {

    @IBOutlet weak var happieView: UIView!
    @IBOutlet weak var happiePB: circularPB!
    @IBOutlet weak var botView: UIView!
    @IBOutlet weak var topView: UIView!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.happiePB.progress = 0
        self.defaults.setFloat(0.0, forKey: "currentCount")
        self.defaults.setFloat(5.0, forKey: "maxCount")
        self.botView.addSubview(self.happieView)
        self.topView.addSubview(self.happieView)
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
