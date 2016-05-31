//
//  AppDelegate.swift
//  mark1
//
//  Created by Josse on 20/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import FBSDKCoreKit

extension UIViewController
{
    func initKeyboard() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y = -keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    func dismissKeyboard() {
        view.endEditing(true)
        self.initKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return false
    }
}

extension UIView
{
    func addBackground()
    {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "background_connexion.png")
        
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}

//===============>MARK ::> Extension made in Paul ^^ sert à appliquer le design aux text fields in current view

extension UITextField {
    func effect(placeholder :String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        self.layer.masksToBounds = false
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        self.textColor = UIColor.whiteColor()
        let height = CGFloat(5.0)
        let width = CGFloat(1.0)
        let borderBottom = CALayer()
        borderBottom.borderColor = UIColor.whiteColor().CGColor
        borderBottom.frame = CGRect(x: -self.frame.size.width * 0.03, y: self.frame.size.height - width - self.frame.size.height * 0.12, width: self.frame.size.width * 0.78/*self.frame.size.width * 1.06*/, height: width)
        borderBottom.borderWidth = width
        self.layer.addSublayer(borderBottom)
        let borderLeft = CALayer()
        borderLeft.borderColor = UIColor.whiteColor().CGColor
        borderLeft.frame = CGRect(x: -self.frame.size.width * 0.03, y: self.frame.size.height - height - self.frame.size.height * 0.12, width: width, height: height)
        borderLeft.borderWidth = width
        self.layer.addSublayer(borderLeft)
        let borderRight = CALayer()
        borderRight.borderColor = UIColor.whiteColor().CGColor
        borderRight.frame = CGRect(x: self.frame.size.width * 0.75 - width, y: self.frame.size.height - height - self.frame.size.height * 0.12, width: width, height: height)
        borderRight.borderWidth = width
        self.layer.addSublayer(borderRight)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let userSession: NSUserDefaults = NSUserDefaults.standardUserDefaults()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var initialViewController: UIViewController
        
        if(FBSDKAccessToken.currentAccessToken() != nil){
            let vc = mainStoryboard.instantiateViewControllerWithIdentifier("homePage") as! homePageVC
            initialViewController = vc
        }else{
            initialViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainPage") as! mainPageVC
        }
        
        self.window?.rootViewController = initialViewController
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}