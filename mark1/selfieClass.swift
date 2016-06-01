//
//  selfieClass.swift
//  mark1
//
//  Created by Josse on 31/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import UIKit

class selfieClass {
    
    // MARK : attributs
    
    private let id: NSInteger
    private let own_id: NSInteger
    private let own_un: NSString
    private let url: NSString
    private var rate: NSInteger
    private var like: NSInteger
    private var image: UIImage?
    private let outfit: NSString
    
    init(id: NSInteger, own_id: NSInteger, own_un: NSString, url: NSString, rate: NSInteger, like: NSInteger, outfit: NSString)
    {
        self.id = id
        self.own_id = own_id
        self.own_un = own_un
        self.url = url
        self.rate = rate
        self.like = like
        self.outfit = outfit
            
        let data = NSData(contentsOfURL: NSURL(string: url as String)!)
        
        self.image = UIImage(data: data!)
    }
    
    // MARK : getters
    
    func getId() -> NSInteger {
        return self.id
    }
    func getOwnId() -> NSInteger {
        return self.own_id
    }
    func getOwnUn() -> NSString {
        return self.own_un
    }
    func getUrl() -> NSURL {
        let facto = NSURL(string: url as String)!
        return facto
    }
    func getRate() -> NSInteger? {
        return self.rate
    }
    func getLike() -> NSInteger? {
        return self.like
    }
    func getImage() -> UIImage? {
        return self.image!
    }
    func getOutfit() -> NSString {
        return self.outfit
    }

    // MARK : setters
    
    func setLike(nb: NSInteger) {
        self.like = nb
    }
    func setRate(nb: NSInteger) {
        self.rate = nb
    }
}