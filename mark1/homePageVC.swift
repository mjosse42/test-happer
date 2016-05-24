//
//  homePageVC.swift
//  mark1
//
//  Created by Josse on 24/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class homePageVC: UIViewController
{
    // MARK: Properties
    @IBOutlet weak var buttonOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: Actions
    @IBAction func bitchButton(sender: UIButton) {
        let button = buttonOutlet!
        if button.backgroundColor == UIColor.orangeColor() {
            button.backgroundColor = UIColor.magentaColor()
        }
        else if button.backgroundColor == UIColor.magentaColor() {
            button.backgroundColor = UIColor.cyanColor()
        }
        else if button.backgroundColor == UIColor.cyanColor() {
            button.backgroundColor = UIColor.yellowColor()
        }
        else if button.backgroundColor == UIColor.yellowColor() {
            button.backgroundColor = UIColor.redColor()
        }
        else if button.backgroundColor == UIColor.redColor() {
            button.backgroundColor = UIColor.orangeColor()
        }
    }
}