//
//  menu.swift
//  mark1
//
//  Created by paul on 01/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class menu {
    var segueKey: String
    var text: String
    var image: UIImage?
    
    init(segueKey: String, text: String, image: UIImage?) {
        self.segueKey = segueKey
        self.text = text
        self.image = image
    }
}