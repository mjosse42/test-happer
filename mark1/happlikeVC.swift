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
    @IBOutlet weak var happiePB: KDCircularProgress!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let duration: NSTimeInterval = 0.6
         UIView.animateWithDuration(duration, animations: { () -> Void in
         self.happieView.frame = CGRectMake(
         self.happieView.frame.origin.x,
         self.happieView.frame.origin.y - 400,
         self.happieView.frame.size.width,
         self.happieView.frame.size.height)
         })
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("scroller", object: nil)
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
