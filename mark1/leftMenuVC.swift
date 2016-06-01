//
//  leftMenuVC.swift
//  mark1
//
//  Created by paul on 31/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class leftMenuVC: UITableViewController {

    // List of title in menu
    let menu = ["door 1", "door 2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Si je le met ça marche, sinon ça sigabort :D
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
}

extension leftMenuVC {
    // Called when a choice is done
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // Switch for each title from the menu and send specific notification to homePage
        switch indexPath.row {
        case 0:
            NSNotificationCenter.defaultCenter().postNotificationName("openFirst", object: nil)
        case 1:
            NSNotificationCenter.defaultCenter().postNotificationName("openSecond", object: nil)
        default:
            print("indexPath.row:: \(indexPath.row)")
        }
        // Close menu in containerVC
        NSNotificationCenter.defaultCenter().postNotificationName("push", object: nil)
    }
}