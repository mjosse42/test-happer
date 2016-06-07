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
    @IBOutlet weak var botView: UIView!
    @IBOutlet weak var topView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.botView.addSubview(self.happieView)
        self.topView.addSubview(self.happieView)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
