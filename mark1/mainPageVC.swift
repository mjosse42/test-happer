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
    var defaults = NSUserDefaults.standardUserDefaults()
    var jsonData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLogin.readPermissions = ["public_profile","email", "user_friends" ]
        self.fbLogin.delegate = self
        initKeyboard()
        self.view.addBackground()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewControllerWithIdentifier("homePage") as! containerVC
            print("on se déplace")
            presentViewController(vc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: FBSDK

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error != nil
        {
            print(error.localizedDescription)
            return
        }
        else
        {
            let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name,friends"], HTTPMethod: "GET")
            request.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
                if(error == nil)
                {
                    print("result \(result)")
                    let name = result.valueForKey("name") as! NSString
                    let email = result.valueForKey("email") as! NSString
                    print("\(name) \(email)")
                    self.connexion(name, mail: email)
                }
                else
                {
                    print("error \(error)")
                }
            })
        }
    }
    
    func connexion(username: NSString, mail: NSString) {
     
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/fbLogin.php")
        let body = "mail=\(mail)"
        let request = NSMutableURLRequest(URL: url!)
     
        request.HTTPMethod = "POST"
        
        let postData: NSData = body.dataUsingEncoding(NSUTF8StringEncoding)!
     
        request.HTTPBody = postData
     
        let postLength: NSString = String(postData.length)
     
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
     
     
        var res = NSHTTPURLResponse()
        var urlData: NSData?

        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            urlData = data! as NSData
            res = response as! NSHTTPURLResponse
            if res.statusCode >= 200 && res.statusCode < 300 {
                do
                {
                    self.jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                }
                catch
                {
                    print("Catch-Location:: 'mainPageVC' :: Serialization of server's response <jsonData>")
                    return
                }
            }
            else {
                print(res.statusCode)
                return
            }
            
            let id = self.jsonData.valueForKey("id") as! NSInteger
            let mail = self.jsonData.valueForKey("mail") as! NSString
            let credits = self.jsonData.valueForKey("credits") as! NSInteger
            let xp = self.jsonData.valueForKey("exp") as! NSInteger
            let rank = self.jsonData.valueForKey("rank") as! NSInteger
            self.saveUserData(id, name: username, email: mail, credits: credits, xp: xp, rank: rank)

        })
        task.resume()
     
    }
    
    func saveUserData(id: NSInteger, name: NSString, email: NSString, credits: NSInteger, xp: NSInteger, rank: NSInteger) {
        self.defaults.setBool(true, forKey: "loggued")
        self.defaults.setInteger(id, forKey: "id")
        self.defaults.setObject(name, forKey: "userName")
        self.defaults.setObject(email, forKey: "email")
        self.defaults.setInteger(credits, forKey: "credits")
        self.defaults.setInteger(xp, forKey: "exp")
        self.defaults.setInteger(rank, forKey: "rank")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {}
}