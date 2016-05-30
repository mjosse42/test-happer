//
//  signUpVC.swift
//  mark1
//
//  Created by Josse on 25/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class signUpVC: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var Field_1: UITextField!
    @IBOutlet weak var Field_2: UITextField!
    @IBOutlet weak var Field_3: UITextField!
    @IBOutlet weak var Field_4: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addBackground()
        Field_1.delegate = self
        Field_2.delegate = self
        Field_3.delegate = self
        Field_4.delegate = self
    // On appelle respectivement les extends-methods des text fields celle du design puis celles du clavier
        self.initTextField()
        self.initKeyboard()
    }

    func initTextField()
    {
        Field_1.effect("Nom d'Utilisateur")
        Field_2.effect("Adresse Mail")
        Field_3.effect("Mot de Passe")
        Field_4.effect("Confirmer Mot de Passe")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Modifier", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion:nil)
    }
    
    func checkFields() -> Bool {
        if (self.Field_1.text == "")
        {
            doAlert("Champ Vide", message: "Veuillez renseigner un utilisateur")
            return false
        }
        else if (self.Field_2.text == "")
        {
            doAlert("Champ Vide", message: "Veuillez renseigner une adresse mail")
            return false

        }
        else if (self.Field_3.text == "")
        {
            doAlert("Champ Vide", message: "Veuillez choisir un mot de passe")
            return false

        }

        else if (self.Field_4.text == "")
        {
            doAlert("Champ Vide", message: "Veuillez confirmer votre mot de passe")
            return false

        }
        return true
    }
    
    @IBAction func createAccount(sender: UIButton)
    {
        if (!checkFields()) // fonction a ameliorer, meilleur parsing largement envisageable
        {
            return
        }
        
        let login = NSString(string: self.Field_1.text!)
        let mail = NSString(string: self.Field_2.text!)
        let passwd = NSString(string: self.Field_3.text!)
        let conf = NSString(string: self.Field_4.text!)


        if (conf.isEqualToString(passwd as String)) // les deux passwords sont égaux, sinon on ne va pas plus loin
        {
            
            
            var jsonData = NSDictionary()
            let postr = NSString(string : "login=\(login)&passwd=\(passwd)&mail=\(mail)")
            let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/adduser.php")
            
            // comme pour le login pour l'instant
            
            let request = NSMutableURLRequest(URL :url!)
            request.HTTPMethod = "POST"
            
            let postData: NSData = postr.dataUsingEncoding(NSUTF8StringEncoding)!
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
            catch
            {
                print("Catch-Location:: 'signUpVC.swift' :: sendingSyncronousRequest <urlData>")
            }
            
            let res = response as! NSHTTPURLResponse!

            if (res.statusCode >= 200 && res.statusCode < 300)
            {
                
                do
                {
                    jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                }
                catch
                {
                    print("Catch-Location:: 'signUpVC.swift' :: sendingSyncronousRequest <jsonData>")
                }
            }
                
            else
            {
                print("Server Status Code : \(res.statusCode)")
                return
            }
            
            print(jsonData)
            
            let success: NSInteger = jsonData.valueForKey("success") as! NSInteger
            if (success == 1)
            {
                print("SUCCESS")
                performSegueWithIdentifier("signUpToMain", sender: self)
            }
            else
            {
                print("FAIL")
            }
        }

        else // alert passwd don't match
        {
            let alert = UIAlertController(title: "Une erreur est survenue", message: "Les mots de passe ne correspondent pas", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Modifier", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion:nil)
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
    
    @IBAction func tapLogo(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("signUpToMain", sender: self)
    }

}
