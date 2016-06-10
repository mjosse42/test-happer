//
//  cropVC.swift
//  mark1
//
//  Created by paul on 10/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class cropVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var imageView = UIImageView()
    var pickedImage: UIImage!
    var cropedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        initScrollView()
        initImageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! marqueVC
        destination.cropedImage = cropedImage
    }

    func initScrollView() {
        scrollView.delegate = self
        imageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
        scrollView.addSubview(imageView)
    }

    func initImageView() {
        imageView.contentMode = .ScaleAspectFit
        imageView.image = pickedImage
        imageView.contentMode = UIViewContentMode.Center
        imageView.frame = CGRectMake(0, 0, pickedImage.size.width , pickedImage.size.height)
        scrollView.contentSize = pickedImage.size
        let SV_f_s = scrollView.frame.size
        let minScale = min(SV_f_s.width / scrollView.contentSize.width, SV_f_s.height / scrollView.contentSize.height)
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1
        scrollView.zoomScale = minScale
        centerScrollViewContent()
    }

    func centerScrollViewContent() {
        let boudsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        if contentsFrame.size.width < boudsSize.width {
            contentsFrame.origin.x = (boudsSize.width - contentsFrame.size.width) / 2
        } else {
            contentsFrame.origin.x = 0
        }
        if contentsFrame.size.height < boudsSize.height {
            contentsFrame.origin.y = (boudsSize.height - contentsFrame.size.height) / 2
        } else {
            contentsFrame.origin.y = 0
        }
        imageView.frame = contentsFrame
    }

    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContent()
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    @IBAction func cropButton(sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.mainScreen().scale)
        let offset = scrollView.contentOffset
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -offset.x, -offset.y)
        scrollView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        cropedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        performSegueWithIdentifier("cropToMarque", sender: nil)
    }
}
