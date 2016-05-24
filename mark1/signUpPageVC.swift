//
//  signUpPageVC.swift
//  mark1
//
//  Created by Josse on 23/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class signUpPageVC: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passwdTF: UITextField!
    @IBOutlet weak var passwdTF2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginTF.delegate = self
        self.mailTF.delegate = self
        self.passwdTF.delegate = self
        self.passwdTF2.delegate = self
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: UIButton)
    {
        let login = NSString(string: loginTF.text!)
        let mail = NSString(string: mailTF.text!)
        let passwd = NSString(string: passwdTF.text!)
        let conf = NSString(string: passwdTF2.text!)
        
        if (conf.isEqualToString(passwd as String))
        {
            var jsonData = NSDictionary()
            let postr = NSString(string : "login=\(login)&passwd=\(passwd)&mail=\(mail)")
            let url = NSURL(string: "http://192.168.0.50:8888/adduser.php")
            let request = NSMutableURLRequest(URL :url!)
            let postData: NSData = postr.dataUsingEncoding(NSUTF8StringEncoding)!
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            let postLength: NSString = String(postData.length)
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
            print(jsonData)
            let success: NSInteger = jsonData.valueForKey("success") as! NSInteger
            if (success == 1)
            {
                print("new account just created")
            }
            else
            {
                print("nothing created")
            }
        }
        else
        {
            let alert: UIAlertView = UIAlertView()
            alert.title = "Error"
            alert.message = "passwords are differents"
            alert.addButtonWithTitle("OK")
            alert.delegate = self
            alert.show()
        }
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
