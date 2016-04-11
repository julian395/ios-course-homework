
//
//  Settings2ViewController.swift
//  Diary2
//
//  Created by Julian1 on 08.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class Settings2ViewController: UIViewController {
    
    
    @IBOutlet weak var DateAndTimeCell: UITableViewCell!
    @IBOutlet weak var DateCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = NSUserDefaults.standardUserDefaults()
        if settings.boolForKey("dateAndTime")
        {
            DateAndTimeCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            DateCell?.accessoryType = UITableViewCellAccessoryType.None
        }
        else
        {
            DateAndTimeCell?.accessoryType = UITableViewCellAccessoryType.None
            DateCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }


        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onDateTap(sender: AnyObject) {
        if DateCell?.accessoryType == UITableViewCellAccessoryType.None {
            DateCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            DateAndTimeCell?.accessoryType = UITableViewCellAccessoryType.None
        }

    }

    @IBAction func onDateAndTimeTap(sender: AnyObject) {
        if DateAndTimeCell?.accessoryType == UITableViewCellAccessoryType.None {
            DateAndTimeCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            DateCell?.accessoryType = UITableViewCellAccessoryType.None
        }

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
