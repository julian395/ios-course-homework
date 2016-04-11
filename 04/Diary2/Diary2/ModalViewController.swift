//
//  ModalViewController.swift
//  Diary2
//
//  Created by Julian1 on 08.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    
    var dateStr = ""
    var dateNS = NSDate()
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        datePicker = UIDatePicker()
        datePicker.center = view.center
        view.addSubview(datePicker)
        
        datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerChanged(sender: UIDatePicker)
    {
        dateStr = sender.date.formattedRelativeString()
        dateNS = sender.date
    }

    func sendDate(date : String, date2: NSDate)
    {
        DeatilViewController.anotherDateType = date2
        DeatilViewController.anotherDate = date
    }

    @IBAction func SaveAndClose(sender: AnyObject) {
        sendDate(dateStr, date2: dateNS)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    override func didReceiveMemoryWarning() {
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
