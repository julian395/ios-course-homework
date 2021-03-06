//
//  DeatilViewController.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class DeatilViewController: UIViewController, UITextFieldDelegate {

    
      var notes: Diary?
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var textLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView?
    

    
    @IBAction func cloudBut(sender: AnyObject) {
        img = Weather.Cloud
        imageView?.image = UIImage(named: "cloudy_sm")
    }
    
    
    @IBAction func rainBut(sender: AnyObject) {
        img = Weather.Rain
        imageView?.image = UIImage(named: "rain_sm")
    }
    
    
    @IBAction func sunBut(sender: AnyObject) {
        img = Weather.Sun
        imageView?.image = UIImage(named: "sunny_sm")
    }
    
    var dateTXT : String = ""
    var img : Weather = Weather.Default

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = dateTXT
        titleLabel?.text = notes?.title
        textLabel?.text = notes?.text
        img = (notes?.img)!
        titleLabel?.delegate = self
       
        switch img
        {
        case .Default :
            imageView?.image = UIImage(named: "default")
        case .Rain :
            imageView?.image = UIImage(named: "rain_sm")
        case .Sun :
            imageView?.image = UIImage(named: "sunny_sm")
        case .Cloud :
            imageView?.image = UIImage(named: "cloudy_sm")
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        notes?.title = (titleLabel.text)!
        notes?.text = textLabel.text
        notes?.img = img
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        if textView === textView
        {
            notes?.text = textView.text
        }
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