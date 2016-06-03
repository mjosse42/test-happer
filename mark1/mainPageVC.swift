//
//  mainPageVC.swift
//  mark1
//
//  Created by Josse on 20/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class mainPageVC: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate
{
    @IBOutlet weak var fbLogin: FBSDKLoginButtonFR!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLogin.readPermissions = ["public_profile","email", "user_friends" ]
        self.fbLogin.delegate = self
        initKeyboard()
        self.view.addBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: FBSDK

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
             NSOperationQueue.mainQueue().addOperationWithBlock {
                self.performSegueWithIdentifier("mainToHome", sender: self)
            }
        }
        else
        {
            print(error.localizedDescription)
            return
        }
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name,friends"], HTTPMethod: "GET")
        request.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            if(error == nil)
            {
                print("result \(result)")
            }
            else
            {
                print("error \(error)")
            }
        })
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
    }
}