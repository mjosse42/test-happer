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
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homePageVC.openFirst), name: "openFirst", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(homePageVC.openSecond), name: "openSecond", object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSNotificationCenter.defaultCenter().postNotificationName("closeMenuViaNotification", object: nil)
        view.endEditing(true)
    }

    func openFirst() {
        performSegueWithIdentifier("openFirst", sender: nil)
    }

    func openSecond() {
        performSegueWithIdentifier("openSecond", sender: nil)
    }

    @IBAction func toggleMenu(sender: UIBarButtonItem) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleMenu", object: nil)
    }
}