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
        // Do any additional setup after loading the view.
    }

    func initTextField()
    {
        tField_1.effect("Nom d'utilisateur")
        tField_2.effect("Mot de Passe")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connexion(sender: UIButton) {
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
