//
//  FBSDKLoginButtonFR.swift
//  mark1
//
//  Created by paul on 30/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FBSDKLoginButtonFR: FBSDKLoginButton {
    override func setTitle(title: String?, forState state: UIControlState) {
        if title == "Log in with Facebook" {
            super.setTitle("Connexion avec Facebook", forState: state)
        } else if title == "Log out" {
            super.setTitle("Déconnexion", forState: state)
        } else {
            super.setTitle(title, forState: state)
        }
    }
}
