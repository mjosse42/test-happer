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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJSON() -> NSData
    {
        let url: String = "http://192.168.0.50:8888/getproducts.php"
        return NSData(contentsOfURL: NSURL(string: url)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary?
    {
        var boardsDictionary: NSDictionary? = nil
        do
        {
            try boardsDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
        }
        catch
        {
            print("Error")
        }
        return boardsDictionary
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