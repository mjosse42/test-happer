//
//  containerVC.swift
//  mark1
//
//  Created by paul on 31/05/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class containerVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    let leftMenuWidth:CGFloat = 260

    override func viewDidLoad() {
        // Catchers for notification (close menu, clic at button bar from homePage)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.start), name: "start", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.toggleMenu), name: "toggleMenu", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.closeMenu), name: "closeMenu", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.push), name: "push", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.scroller), name: "scroller", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        // Clean catcher when instance are destroyed
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // Scroll to menu
    func openMenu() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    // Scroll to homePage
    func closeMenu(animated: Bool = true) {
        scrollView.setContentOffset(CGPoint(x: leftMenuWidth, y: 0), animated: animated)
    }

    // MARK: Notification catchers

    func start() {
        closeMenu(false)
    }

    // Activate when menu from homePage is tapped
    func toggleMenu() {
        scrollView.contentOffset.x == 0  ? closeMenu() : openMenu()
    }

    func push() {
        scrollView.scrollEnabled = false
        closeMenu()
    }

    func scroller() {
        scrollView.scrollEnabled = true
    }
}