//
//  loginPageVC.swift
//  mark1
//
//  Created by Josse on 26/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class loginPageVC: UIViewController, UITextFieldDelegate
{

    @IBOutlet weak var tField_1: UITextField!
    @IBOutlet weak var tField_2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        tField_1.delegate = self
        tField_2.delegate = self
        self.initKeyboard()
        self.initTextField()
        // Preparation des champs textes et du clavier
    }

    func initTextField()
    {
        tField_1.effect("Nom d'utilisateur")
        tField_2.effect("Mot de Passe")
        // CSS textFields ; ajout de la gestion des placeholders
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func connexion(sender: UIButton) {
        
        let loginMail = tField_1.text! as NSString
        let passwd = tField_2.text! as NSString

        var jsonData = NSDictionary()  // ici, on stockera la réponse serveur, en JSON
//  on prépare l'url avec le POST
        let url = NSURL(string: "http://192.168.0.50:8888/login.php")
        let body = "login=\(loginMail)&passwd=\(passwd)"
// on commence a monter une requete HTTP
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
// et on insère les données encodées en UTF-8
        let postData: NSData = body.dataUsingEncoding(NSUTF8StringEncoding)!
        request.HTTPBody = postData

  //  on aura aussi besoin de la longueur (obselete en 9.3)
        let postLength: NSString = String(postData.length)
        
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        /* on viens d'informer le serveur que l'on souhaite communiquer en JSON  */
        
        var response: NSURLResponse? //  Et en toute logique on attends sa réponse
        var urlData: NSData? // ainsi que d'éventuelles données de la database
        
        do
        {
            // allo ?
            urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        }
        catch
        {
            // je t'entends pas
            print("Catch-Location:: 'loginVC.swift' :: sendingSynchonousRequest <urlData>")
            return
        }
        
        // - allo ? c'est le client ?
        // - oui oui oui ! j'ai une requete pour toi !
        
        
         /* On a maintenant besoin de " decrypter " sa réponse */
        
        let res = response as! NSHTTPURLResponse!

        if res.statusCode >= 200 && res.statusCode < 300 // voir statusCode => go Google // ici tout c'est bien passé, on a une réponse
        {
            
            // on ouvre quand meme le colis avec précaution : try catch !
            
            do
            {
                jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary // On convertis en Dictionnaire, ce sera plus facile a lire
            }
            catch
            {
                print("Catch-Location:: 'loginPageVC' :: Serialization of server's response <jsonData>")
                return
            }
        }

         /* On a réussi à serialiser les données */

        else
        {
            // on oublie pas de regarder l'erreur 404 qui nous geule qu'on a posté un mauvais url
            print(res.statusCode)
            return
        }
        print(jsonData) // Pour avoir le retour sur le log, j'aime bien.

        let success = jsonData.valueForKey("id") as! NSInteger
    // la variable success contient 0 ou 1 Si s'est bien log ou pas
        if (success > 0) {
            print("SUCCESS")
            performSegueWithIdentifier("loginToHome", sender: self) // On bouge vers le home
        }
        else {
            print("FAIL") // on en reste la, l'utilisateur s'est planté
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
    @IBAction func tapFunc(sender: UITapGestureRecognizer)
    {
        performSegueWithIdentifier("loginToMain", sender: self)
    }

}
