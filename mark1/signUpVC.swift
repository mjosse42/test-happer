//
//  signUpVC.swift
//  mark1
//
//  Created by Josse on 25/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

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
            self.view.frame.origin.y -= keyboardSize.height
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
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
        if (!checkFields())
        {
            return
        }
        //return // =====>> MARK: A virer
        let login = NSString(string: self.Field_1.text!)
        let mail = NSString(string: self.Field_2.text!)
        let passwd = NSString(string: self.Field_3.text!)
        let conf = NSString(string: self.Field_4.text!)
        if (conf.isEqualToString(passwd as String))
        {
            var jsonData = NSDictionary()
            let postr = NSString(string : "login=\(login)&passwd=\(passwd)&mail=\(mail)")
            let url = NSURL(string: "http://192.168.0.50:8888/adduser.php")
            let request = NSMutableURLRequest(URL :url!)
            let postData: NSData = postr.dataUsingEncoding(NSASCIIStringEncoding)!
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            print(request.HTTPBody)
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
                        print("Erreure de récuperation du fichier JSON")
                    }
                }
                else
                {
                    print(res.statusCode)
                    return
                }
            }
            print(jsonData)
            let success: NSInteger = jsonData.valueForKey("success") as! NSInteger
            if (success == 1)
            {
                print("Un compte à été ajouté")
            }
            else
            {
                print("Rien n'a été créé")
            }
        }
        else
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
