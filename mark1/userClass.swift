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
    case silver = 1
    case gold
    case platine
    case ruby
    case saphir
}

class userClass
{
    private var userId: NSInteger
    private var userName: NSString
    private var userMail: NSString
    private var loggued: Bool
    private var rank: eRank
    private var credit: NSInteger
    private var xP: NSInteger
    
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
    
    func getUserId() -> NSInteger
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
    
    func getCredit() -> NSInteger
    {
        return self.credit
    }
    
    func getXp() -> NSInteger
    {
        return self.xP
    }
    
    // MARK: setters
    
    func setUserId(new: NSInteger)
    {
        self.userId = new
    }
    
    func loggued_in()
    {
        self.loggued = true
    }
    
    func loggued_out()
    {
        self.loggued = false
    }
    
    func setUserName(new: NSString)
    {
        self.userName = new
    }
    
    func setUserMail(new: NSString)
    {
        self.userMail = new
    }
    
    func addCredit(amount: NSInteger)
    {
        self.credit += amount
    }
    
    func addXp(amount: NSInteger)
    {
        self.xP += amount
    }
    
    func setRank(rank: NSInteger)
    {
        switch rank
        {
            case 1:
                self.rank = eRank.silver
            case 2:
                self.rank = eRank.gold
            case 3:
                self.rank = eRank.platine
            case 4:
                self.rank = eRank.ruby
            case 5:
                self.rank = eRank.saphir
            default:
                self.rank = eRank.silver
        }
    }
}