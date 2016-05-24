//
//  userClass.swift
//  mark1
//
//  Created by Josse on 24/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//


import Foundation

enum eRank: Int
{
    case silver
    case gold
    case platine
    case ruby
    case saphir
}

class userClass
{
    private var userId: Int
    private var userName: NSString
    private var userMail: NSString
    private var loggued: Bool
    private var rank: eRank
    private var credit: Int
    private var xP: Int
    
    init()
    {
        self.userId = 0
        self.userName = "default"
        self.userMail = "default"
        self.loggued = false
        self.rank = eRank.silver
        self.credit = 0
        self.xP = 0
    }
    
    func sync()
    {
        // Connexion au serveur et update du compte
    }
    
    func upRank()
    {
        self.xP = 0
        self.rank = eRank(rawValue: rank.rawValue + 1)!
    }
    
    // MARK: getters
    
    func getUserId() -> Int
    {
        return self.userId
    }
    
    func getUserName() -> NSString
    {
        return self.userName
    }
    
    func getUserMail() -> NSString
    {
        return self.userMail
    }
    
    func getRank() -> eRank
    {
        return self.rank
    }
    
    func getCredit() -> Int
    {
        return self.credit
    }
    
    func getXp() -> Int
    {
        return self.xP
    }
    
    // MARK: setters
    
    func setUserName(new: NSString)
    {
        self.userName = new
    }
    
    func setUserMail(new: NSString)
    {
        self.userMail = new
    }
    
    func addCredit(amount: Int)
    {
        self.credit += amount
    }
    
    func addXp(amount: Int)
    {
        self.xP += amount
    }
}