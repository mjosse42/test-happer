//
//  mainPageVC.swift
//  mark1
//
//  Created by Josse on 20/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

extension UIViewController
{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        self.hideKeyboardWhenTappedAround()
    }
}
class mainPageVC: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwdTF: UITextField!
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginTF.delegate = self
        self.passwdTF.delegate = self
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                print("loggued in")
            }
        }
    }
}

