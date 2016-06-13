//
//  marqueVC.swift
//  mark1
//
//  Created by paul on 10/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class marqueVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var cropedImage: UIImage!
    @IBOutlet weak var OOTD: UIButton!
    var ootdLeftBar: UIView!
    var ootdRightBar: UIView!
    @IBOutlet weak var OOTN: UIButton!
    var ootnLeftBar: UIView!
    var ootnRightBar: UIView!
    var editingTextField: Bool = false
    var filledArea: [Int: [String: CGPoint]] = [:]
    var textFields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        designFrame()
        let tap = UITapGestureRecognizer(target: self, action: #selector(marqueVC.addDetails))
        tap.numberOfTapsRequired = 1
        containerView.addGestureRecognizer(tap)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(marqueVC.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(marqueVC.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("push", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func designFrame() {
        imageView.image = cropedImage
        OOTD.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05)
        OOTD.layer.masksToBounds = true
        ootdLeftBar = UIView(frame: CGRectMake(-5, 0, 10, OOTD.frame.size.height))
        ootdLeftBar.backgroundColor = UIColor.blackColor()
        OOTD.addSubview(ootdLeftBar)
        ootdRightBar = UIView(frame: CGRectMake(OOTD.frame.size.width - 5, 0, 10, OOTD.frame.size.height))
        ootdRightBar.backgroundColor = UIColor.blackColor()
        OOTD.addSubview(ootdRightBar)
        OOTN.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05)
        OOTN.layer.masksToBounds = true
        ootnLeftBar = UIView(frame: CGRectMake(-5, 0, 10, OOTN.frame.size.height))
        ootnLeftBar.backgroundColor = UIColor.blackColor()
        OOTN.addSubview(ootnLeftBar)
        ootnRightBar = UIView(frame: CGRectMake(OOTN.frame.size.width - 5, 0, 10, OOTN.frame.size.height))
        ootnRightBar.backgroundColor = UIColor.blackColor()
        OOTN.addSubview(ootnRightBar)
    }

    func addDetails(touch: UITapGestureRecognizer) {
        if editingTextField == false {
            let touchPoint = touch.locationInView(imageView)
            print("touchPoint is \(touchPoint)...")
            if touchPoint.y + 34.5 < imageView.frame.height &&
                touchPoint.x + 92 < imageView.frame.width &&
                touchPoint.x - 8 > 0 &&
                checkIfAreaIsEmpty(touchPoint) {
                creatTextField(touchPoint)
            } else {
                print(" ... but we cant creat textField here")
            }
        } else {
            view.endEditing(true)
            editingTextField = false
            imageView.becomeFirstResponder()
        }
    }

    func checkIfAreaIsEmpty(touchPoint: CGPoint) -> Bool {
        let nSP: CGPoint = CGPoint(x: touchPoint.x - 8, y: touchPoint.y)
        let nEP: CGPoint = CGPoint(x: touchPoint.x + 92, y: touchPoint.y + 34.5)
        let nW: CGFloat = nEP.x - nSP.x
        let nH: CGFloat = nEP.y - nSP.y
        var i: Int = 0
        while let area:[String: CGPoint] = filledArea[i] {
            let sP: CGPoint = area["startPoint"]!
            let eP: CGPoint = area["endPoint"]!
            let w: CGFloat = eP.x - sP.x
            let h: CGFloat = eP.y - sP.y
            if nSP.x - sP.x < nW && sP.x - nSP.x < w && nSP.y - sP.y < nH && sP.y - nSP.y < h {
                return false
            } else {
                i += 1
            }
        }
        let area = ["startPoint": nSP, "endPoint": nEP]
        filledArea[i] = area
        return true
    }

    func creatTextField(touchPoint: CGPoint) {
        let triangleView = UIImageView(frame: CGRectMake(touchPoint.x - 8, touchPoint.y, 16, 13.5))
        triangleView.image = UIImage(named: "triangle")
        imageView.addSubview(triangleView)
        let textField = UITextField(frame: CGRectMake(touchPoint.x - 8, touchPoint.y +  13.5, 100, 21))
        textField.font = UIFont(name: "Helvetica", size: 12.0)
        textField.placeholder = "Marque"
        textField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8).CGColor
        let textFieldImageView = UIView(frame: CGRectMake(0, 0, 9, 21))
        textFieldImageView.backgroundColor = UIColor.clearColor()
        let textFieldImage = UIView(frame: CGRectMake(3, 3, 3, 15))
        textFieldImage.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        textFieldImageView.addSubview(textFieldImage)
        textField.leftView = textFieldImageView
        textField.leftViewMode = UITextFieldViewMode.Always
        textFields += [textField]
        imageView.addSubview(textField)
        textField.delegate = self
        textField.becomeFirstResponder()
    }

    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y = -keyboardSize.height + imageView.frame.origin.y
        }
    }

    override func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        editingTextField = true
    }

    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        editingTextField = false
        return true
    }

    @IBAction func OOTDButton(sender: UIButton) {
        if ootdLeftBar.frame.origin.x == -5 && ootdRightBar.frame.origin.x == OOTD.frame.size.width - 5 {
            ootdLeftBar.frame.origin.x += 5
            ootdRightBar.frame.origin.x -= 5
            OOTD.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        }
        if ootnLeftBar.frame.origin.x == 0 && ootnRightBar.frame.origin.x == OOTN.frame.size.width - 10 {
            ootnLeftBar.frame.origin.x -= 5
            ootnRightBar.frame.origin.x += 5
            OOTN.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05)
        }
    }

    @IBAction func OOTNButton(sender: UIButton) {
        if ootnLeftBar.frame.origin.x == -5 && ootnRightBar.frame.origin.x == OOTN.frame.size.width - 5 {
            ootnLeftBar.frame.origin.x += 5
            ootnRightBar.frame.origin.x -= 5
            OOTN.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        }
        if ootdLeftBar.frame.origin.x == 0 && ootdRightBar.frame.origin.x == OOTD.frame.size.width - 10 {
            ootdLeftBar.frame.origin.x -= 5
            ootdRightBar.frame.origin.x += 5
            OOTD.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05)
        }
    }

    @IBAction func saveSelfieButton(sender: UIButton) {
        if ootdLeftBar.frame.origin.x == -5 && ootnLeftBar.frame.origin.x == -5 {
            print("Need to select one of the hashtag (#OOTD or #OOTN)")
        } else {
            var postString: String = String()
            if ootdLeftBar.frame.origin.x == 0 {
                postString += "OutfitOfThe=Day"
            } else {
                postString += "OutfitOfThe=Night"
            }
            var i: Int = 0
            while let area:[String: CGPoint] = filledArea[i] {
                postString += "&label\(i + 1)=\(textFields[i].text!)&sp\(i + 1)X=\(area["startPoint"]!.x)&sp\(i + 1)Y=\(area["startPoint"]!.y)&ep\(i + 1)X=\(area["endPoint"]!.x)&ep\(i + 1)Y=\(area["endPoint"]!.y)"
                i += 1
            }
            print(postString)
            /*
             var jsonData = NSDictionary()
             let postNSString = NSString(string: postString)
             let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/adduser.php")
             let request = NSMutableURLRequest(URL :url!)
             let session = NSURLSession.sharedSession()
             request.HTTPMethod = "POST"
             let postData: NSData = postNSString.dataUsingEncoding(NSUTF8StringEncoding)!
             request.HTTPBody = postData
             let postLength: NSString = String(postData.length)
             request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
             request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
             request.setValue("application/json", forHTTPHeaderField: "Accept")
             var urlData: NSData?
             let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
             urlData = data! as NSData
             let res = response as! NSHTTPURLResponse
             if res.statusCode >= 200 && res.statusCode < 300 {
             do {
             jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
             } catch {
             print("Catch-Location:: 'loginPageVC' :: Serialization of server's response <jsonData>")
             return
             }
             } else {
             print(res.statusCode)
             return
             }
             print(jsonData)
             let success = jsonData.valueForKey("success") as! NSInteger
             if (success > 0) {
             print("SUCCESS")
             self.performSegueWithIdentifier("signUpToMain", sender: self)
             } else {
             print("FAIL")
             }
             })
             task.resume()
             */
        }
    }
}
