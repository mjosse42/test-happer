//
//  leftMenuVC.swift
//  mark1
//
//  Created by paul on 31/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class leftMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // List of title in menu
    var menuList: [menu] = []
    @IBOutlet weak var footerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        loadSampleMenu()
        customFooter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! menuCell
        cell.cellImage.image = menuList[indexPath.row].image
        cell.cellLabel.text = menuList[indexPath.row].text
        return cell
    }

    // Called when a choice is done
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // Switch for each title from the menu and send specific notification to homePage
        switch indexPath.row {
        case 0..<9:
            let dictionary = ["toOpen" : menuList[indexPath.row].segueKey]
            NSNotificationCenter.defaultCenter().postNotificationName("open", object: dictionary)
        default:
            print("indexPath.row:: \(indexPath.row)")
        }
        // Close menu in containerVC and disable scroll
        NSNotificationCenter.defaultCenter().postNotificationName("push", object: nil)
        if indexPath.row == 0 {
            NSNotificationCenter.defaultCenter().postNotificationName("scroller", object: nil)
        }
    }

    func customNavBar() {
        let nav = self.navigationController!.navigationBar
        nav.barTintColor = UIColor.blackColor()
        nav.tintColor = UIColor.whiteColor()
    }
    
    func loadSampleMenu() {
        let icone1 = UIImage(named: "IconeActu")!
        let menu1 = menu(segueKey: "actuSegue", text: "Fil d'actualité", image: icone1)
        let icone2 = UIImage(named: "IconePartage")!
        let menu2 = menu(segueKey: "partageSegue", text: "Partager mon style", image: icone2)
        let icone3 = UIImage(named: "IconeHapplike")!
        let menu3 = menu(segueKey: "happlikeSegue", text: "Happ'like", image: icone3)
        let icone4 = UIImage(named: "IconeDressing")!
        let menu4 = menu(segueKey: "dressingSegue", text: "Mon dressing", image: icone4)
        let icone5 = UIImage(named: "IconeProduit")!
        let menu5 = menu(segueKey: "produitSegue", text: "Produit", image: icone5)
        let icone6 = UIImage(named: "IconeWishlist")!
        let menu6 = menu(segueKey: "wishlistSegue", text: "Ma wishlist", image: icone6)
        let icone7 = UIImage(named: "IconeCoeur")!
        let menu7 = menu(segueKey: "coeurSegue", text: "Mes coups de coeur", image: icone7)
        let icone8 = UIImage(named: "IconeAmis")!
        let menu8 = menu(segueKey: "amisSegue", text: "Amis/Parrainage", image: icone8)
        let icone9 = UIImage(named: "IconeCompte")!
        let menu9 = menu(segueKey: "compteSegue", text: "Mon compte", image: icone9)
        menuList += [menu1, menu2, menu3, menu4, menu5, menu6, menu7, menu8, menu9]
    }

    func customFooter () {
        let borderTop = CALayer()
        borderTop.borderColor = UIColor.blackColor().CGColor
        borderTop.frame = CGRect(x: 0.0, y: 0.0, width: self.footerView.layer.frame.size.width, height: 1.0)
        borderTop.borderWidth = 1.0
        self.footerView.layer.addSublayer(borderTop)
    }
}