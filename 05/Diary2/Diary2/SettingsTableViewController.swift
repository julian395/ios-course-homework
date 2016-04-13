//
//  SettingsTableViewController.swift
//  Diary2
//
//  Created by Julian1 on 03.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var datting = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        datting = ["Change Date Formatt"]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datting.count
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //Call UIAlertAction**************************************************************
        
        var text = ""
        if NotesTableViewController.dateType {
            text = "Date and Time"
        }
        else
        {
            text = "Date"
        }
        let optionMenu = UIAlertController(title:nil, message: "Current formatt is  \(text)", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)

        let CallDateAndTime =
            {
                (action: UIAlertAction!) -> Void in
                let alertMessage = UIAlertController(title: "Congratulation!", message: "Your current date formatt is DATE AND TIME!", preferredStyle: .Alert)
                alertMessage.addAction(UIAlertAction(title:"OK", style: .Default, handler: nil))
                self.presentViewController(alertMessage, animated:true, completion:nil)
                NotesTableViewController.dateType = true
        }
        let CallDate =
            {
                (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Congratulation!", message: "Your current date formatt is DATE!", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title:"OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated:true, completion:nil)
                NotesTableViewController.dateType = false
            }
        let callActionD = UIAlertAction(title: "Date", style: .Default, handler: CallDate)
        let callActionDaT = UIAlertAction(title: "Date and Time", style: .Default, handler: CallDateAndTime)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(callActionD)
        optionMenu.addAction(callActionDaT)
        self.presentViewController(optionMenu, animated:true, completion: nil)
        //end of UIAlertAction**********************************************************************************
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellSet", forIndexPath: indexPath)

        cell.textLabel!.text = datting[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
