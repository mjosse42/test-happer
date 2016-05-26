//
//  signUpv2VC.swift
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    func effect() {
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        self.textColor = UIColor.whiteColor()
        let height = CGFloat(5.0)
        let width = CGFloat(1.0)
        let borderBottom = CALayer()
        borderBottom.borderColor = UIColor.whiteColor().CGColor
        borderBottom.frame = CGRect(x: 0.0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        borderBottom.borderWidth = width
        self.layer.addSublayer(borderBottom)
        let borderLeft = CALayer()
        borderLeft.borderColor = UIColor.whiteColor().CGColor
        borderLeft.frame = CGRect(x: 0.0, y: self.frame.size.height - height, width: width, height: height)
        borderLeft.borderWidth = width
        self.layer.addSublayer(borderLeft)
        let borderRight = CALayer()
        borderRight.borderColor = UIColor.whiteColor().CGColor
        borderRight.frame = CGRect(x: self.frame.size.width - width, y: self.frame.size.height - height, width: width, height: height)
        borderRight.borderWidth = width
        self.layer.addSublayer(borderRight)
        self.layer.masksToBounds = true
    }
}

class signUpv2VC: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var Field_1: UITextField!
    @IBOutlet weak var Field_2: UITextField!
    @IBOutlet weak var Field_3: UITextField!
    @IBOutlet weak var Field_4: UITextField!

    @IBAction func tgrField_1(sender: UITapGestureRecognizer) {
        self.Field_1.text = ""
    }
    
    @IBAction func tgrField_2(sender: UITapGestureRecognizer) {
        self.Field_2.text = ""
    }
    
    @IBAction func tgrField_3(sender: UITapGestureRecognizer) {
        self.Field_3.text = ""
    }
    
    @IBAction func tgrField_4(sender: UITapGestureRecognizer) {
        self.Field_4.text = ""
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addBackground()
        Field_1.delegate = self
        Field_2.delegate = self
        Field_3.delegate = self
        Field_4.delegate = self
    // On appelle respectivement les extends-methods des text fields celle du design puis celles du clavier
        Field_1.effect()
        Field_1.attributedPlaceholder = NSAttributedString(string:"  Nom d'Utilisateur", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        Field_2.effect()
        Field_2.attributedPlaceholder = NSAttributedString(string: "  Adresse Mail", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        Field_3.effect()
        Field_3.attributedPlaceholder = NSAttributedString(string: "  Mot de Passe", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        Field_4.effect()
        Field_4.attributedPlaceholder = NSAttributedString(string: "  Confirmer Mot de Passe", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        initKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doAlert(title: String, message: String) {
        
        let alert: UIAlertView = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle("Modifier")
        alert.delegate = self
        alert.show()

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
            self.Field_1.text = "  Nom d'Utilisateur"
            self.Field_2.text = "  Adresse Mail"
            self.Field_3.text = "  Mot de Passe"
            self.Field_4.text = "  Confirmer Mot de Passe"
            return
        }
        return // =====>> MARK: A virer
        let login = NSString(string: Field_1.text!)
        let mail = NSString(string: Field_2.text!)
        let passwd = NSString(string: Field_3.text!)
        let conf = NSString(string: Field_4.text!)
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
                        print("Erreure de récuperation du fichier JSON")
                    }
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
            let alert: UIAlertView = UIAlertView()
            alert.title = "Une erreur est survenue"
            alert.message = "Les mots de passe ne correspondent pas"
            alert.addButtonWithTitle("Modifier")
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
