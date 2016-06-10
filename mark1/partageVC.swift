//
//  partageVC.swift
//  mark1
//
//  Created by paul on 01/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class partageVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let imagePicker: UIImagePickerController? = UIImagePickerController()
    var pickedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("scroller", object: nil)
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
