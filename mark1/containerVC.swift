//
//  containerVC.swift
//  mark1
//
//  Created by paul on 31/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class containerVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    let leftMenuWidth:CGFloat = 260

    override func viewDidLoad() {
        // Close menu at start
        dispatch_async(dispatch_get_main_queue()) {
            self.closeMenu(false)
        }
        // Catchers for notification (close menu, clic at button bar from homePage and rotation juste au cas ou, on sais jamais, sur un malentendu, ça peut passer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.toggleMenu), name: "toggleMenu", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.closeMenuViaNotification), name: "closeMenuViaNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Scroll to homePage
    func closeMenu(animated:Bool = true){
        scrollView.setContentOffset(CGPoint(x: leftMenuWidth, y: 0), animated: animated)
    }

    // Scroll to menu
    func openMenu(){
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    deinit {
        // Clean catcher when instance are destroyed
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK: Notification catchers
    func closeMenuViaNotification(){
        closeMenu()
    }

    // Activate when menu from homePage is tapped
    func toggleMenu(){
        scrollView.contentOffset.x == 0  ? closeMenu() : openMenu()
    }

    func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            dispatch_async(dispatch_get_main_queue()) {
                self.closeMenu()
            }
        }
    }
}