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
        dispatch_async(dispatch_get_main_queue()) {
            self.closeMenu(false)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.toggleMenu), name: "toggleMenu", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.closeMenuViaNotification), name: "closeMenuViaNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(containerVC.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func toggleMenu(){
        scrollView.contentOffset.x == 0  ? closeMenu() : openMenu()
    }

    func closeMenuViaNotification(){
        closeMenu()
    }

    func closeMenu(animated:Bool = true){
        scrollView.setContentOffset(CGPoint(x: leftMenuWidth, y: 0), animated: animated)
    }

    func openMenu(){
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            dispatch_async(dispatch_get_main_queue()) {
                self.closeMenu()
            }
        }
    }
}

extension containerVC : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scrollView.contentOffset.x:: \(scrollView.contentOffset.x)")
    }

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollView.pagingEnabled = true
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollView.pagingEnabled = false
    }
}