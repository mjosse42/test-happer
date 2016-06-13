//
//  partageVC.swift
//  mark1
//
//  Created by paul on 01/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class partageVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var chargerButton: UIButton!
    @IBOutlet weak var prendreButton: UIButton!
    let imagePicker: UIImagePickerController? = UIImagePickerController()
    var pickedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker?.delegate = self
        chargerButton.layer.cornerRadius = (chargerButton.frame.size.height / 2) - 3
        prendreButton.layer.cornerRadius = (prendreButton.frame.size.height / 2) - 3
        styleLabel.layer.masksToBounds = true
        let borderBottom = CALayer()
        borderBottom.borderColor = UIColor.blackColor().CGColor
        borderBottom.frame = CGRect(x: 0.0, y: styleLabel.frame.height - 1.0, width: styleLabel.frame.width, height: 1.0)
        borderBottom.borderWidth = 1.0
        styleLabel.layer.addSublayer(borderBottom)
        let borderTop = CALayer()
        borderTop.borderColor = UIColor.blackColor().CGColor
        borderTop.frame = CGRect(x: styleLabel.frame.width / 4, y: 0.0, width: styleLabel.frame.width / 2, height: 1.0)
        borderTop.borderWidth = 1.0
        styleLabel.layer.addSublayer(borderTop)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("push", object: nil)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("scroller", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! cropVC
        destination.pickedImage = pickedImage
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        pickedImage = image
        dismissViewControllerAnimated(false, completion: {() -> Void in self.performSegueWithIdentifier("partageToCrop", sender: nil)})
    }
    @IBAction func chargerPhoto(sender: UIButton) {
        imagePicker!.allowsEditing = false
        imagePicker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker!, animated: true, completion: nil)
    }
    @IBAction func prendrePhoto(sender: UIButton) {
        if UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker!.allowsEditing = false
            imagePicker!.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker!.cameraCaptureMode = .Photo
            presentViewController(imagePicker!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}
