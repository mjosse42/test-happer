//
//  homePageVC.swift
//  mark1
//
//  Created by Josse on 27/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class homePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Send notification "closeMenuViaNotification"
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
        // Catchers for notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homePageVC.openFirst), name: "openFirst", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homePageVC.openSecond), name: "openSecond", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        // Clean catcher when instance are destroyed
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // Tap on homePage activate this (even if menu is open)
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
        view.endEditing(true)
    }

    // Function called when notifications are catched in viewDidLoad
    func openFirst() {
        performSegueWithIdentifier("openFirst", sender: nil)
    }

    func openSecond() {
        performSegueWithIdentifier("openSecond", sender: nil)
    }

    @IBAction func toggleMenu(sender: UIBarButtonItem) {
        // Send notification "toggleMenu"
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }
}