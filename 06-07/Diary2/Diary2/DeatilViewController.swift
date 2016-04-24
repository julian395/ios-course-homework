//
//  DeatilViewController.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class DeatilViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    

      static var anotherDateType = NSDate()
      static var anotherDate = ""
      var dateTXT : String = ""
      var img : Weather = Weather.Default
      var notes: Diary?
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var textLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView?
    
    @IBAction func cloudBut(sender: AnyObject) {
        img = Weather.Cloud
        imageView?.image = UIImage(named: "cloudy_sm")
        self.view.backgroundColor = .blueColor()
    }
    
    
    @IBAction func rainBut(sender: AnyObject) {
        img = Weather.Rain
        imageView?.image = UIImage(named: "rain_sm")
        self.view.backgroundColor = .whiteColor()
    }
    
    
    @IBAction func sunBut(sender: AnyObject) {
        img = Weather.Sun
        imageView?.image = UIImage(named: "sunny_sm")
        self.view.backgroundColor = .yellowColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        if !DeatilViewController.anotherDate.isEmpty
        {
            title = DeatilViewController.anotherDate
        }
        else
        {
            title = dateTXT
        }
        if title == DeatilViewController.anotherDate
        {
            DeatilViewController.anotherDate = ""
        }
    }
    
    override func viewDidLoad()
    {
        textLabel.backgroundColor = .clearColor()
        titleLabel.backgroundColor = .clearColor()
        DeatilViewController.anotherDate = ""
        self.textLabel.delegate = self
        self.titleLabel.delegate = self
        super.viewDidLoad()
        titleLabel?.text = notes?.title
        textLabel?.text = notes?.text
        img = (notes?.img)!
        titleLabel?.delegate = self
        switch img
        {
        case .Default :
            imageView?.image = UIImage(named: "default")
            self.view.backgroundColor = .whiteColor()
        case .Rain :
            imageView?.image = UIImage(named: "rain_sm")
            self.view.backgroundColor = .whiteColor()
        case .Sun :
            imageView?.image = UIImage(named: "sunny_sm")
            self.view.backgroundColor = .yellowColor()
        case .Cloud :
            imageView?.image = UIImage(named: "cloudy_sm")
            self.view.backgroundColor = .blueColor()
        }
        
         titleLabel.addTarget(self, action: "myTargetFunction:", forControlEvents: UIControlEvents.TouchDown)
    }
    

    func myTargetFunction(textField: UITextField) {
        // user touch field
        if titleLabel.text == "Tap to write title"
        {
        titleLabel.text = ""
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        DeatilViewController.anotherDate = ""
        notes?.title = (titleLabel.text)!
        notes?.text = textLabel.text
        notes?.img = img
        if title != dateTXT
        {
        notes?.date = DeatilViewController.anotherDateType
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textLabel.text == "Empty"
        {
        textLabel.text = ""
        }
        textLabel.becomeFirstResponder()
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textLabel.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func textViewDidEndEditing(textView: UITextView)
    {
        if textView === textView
        {
            notes?.text = textView.text
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}