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
    @IBOutlet weak var fbLogin: FBSDKLoginButton!
    
    let userSession: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLogin.setTitle("Connexion avec Facebook", forState: UIControlState.Normal)
        self.fbLogin.readPermissions = ["public_profile","email", "user_friends" ]
        self.fbLogin.delegate = self
        //self.loginTF.delegate = self
        //self.passwdTF.delegate = self
        initKeyboard()
        self.view.addBackground()
         if (FBSDKAccessToken.currentAccessToken() != nil)
        {
           // performSegueWithIdentifier("logToHome", sender: self)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func login(login: NSString, passwd: NSString) -> NSDictionary?
    {
        var jsonData: NSDictionary = NSDictionary()
        let postr: NSString = "login=\(login)&passwd=\(passwd)"
        let url: NSURL = NSURL(string: "http://192.168.0.50:8888/login.php")!
        let postData: NSData = postr.dataUsingEncoding(NSUTF8StringEncoding)!
        let postLength: NSString = String(postData.length)
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        var response: NSURLResponse?
        var urlData: NSData?
        do
        {
          urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        }
        catch _ as NSError
        {
            urlData = nil
        }
        catch
        {
            fatalError()
        }
        if (urlData != nil)
        {
            let res = response as! NSHTTPURLResponse!
            if (res.statusCode >= 200 && res.statusCode < 300)
            {
                do
                {
                   jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                }
                catch
                {
                    print("Error")
                }
            }
        }
        print (jsonData)
        return jsonData
    }

    @IBAction func loginButton(sender: UIButton)
    {
        let username: NSString = loginTF.text!
        let userpass: NSString = passwdTF.text!
        if (username.isEqualToString("") || userpass.isEqualToString(""))
        {
            let alert: UIAlertView = UIAlertView()
            alert.title = "Error";
            alert.message = "Empty field !"
            alert.addButtonWithTitle("OK")
            alert.delegate = self
            alert.show()
        }
        else
        {
            let jsonData = login(username, passwd: userpass)
            let success: NSInteger = jsonData!.valueForKey("id") as! NSInteger
            if (success == -1)
            {
                print("login failed")
                let alert: UIAlertView = UIAlertView()
                alert.title = "Error";
                alert.message = "Wrong login or password"
                alert.addButtonWithTitle("OK")
                alert.delegate = self
                alert.show()
            }
            else
            {
                let user = userClass()
                print("loggued in")
                user.setUserId(jsonData!.valueForKey("id") as! NSInteger)
                user.setUserName(jsonData!.valueForKey("login") as! NSString)
                user.setUserMail(jsonData!.valueForKey("mail") as! NSString)
                user.setRank(jsonData!.valueForKey("rank") as! NSInteger)
                user.addXp(jsonData!.valueForKey("exp") as! NSInteger)
                user.addCredit(jsonData!.valueForKey("credit") as! NSInteger)
                userSession.setObject(user, forKey: "user")
                user.loggued_in()
            }
        }
    }
 */
    // MARK: FBSDK
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
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

