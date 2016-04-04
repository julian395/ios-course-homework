//
//  NotesTableViewController.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    @IBAction func SetBut(sender: AnyObject) {
    }
    
    var notes = [Diary]()
    
    static var dateType = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notes.append(Diary(title:"It's great", text:"Today was a beautiful day!", img: "0" ))
        notes.append(Diary(title:"I'm layzee", text:"It's very hard to study", img: "1"))
        notes.append(Diary(title:"Want sleep", text:"I'm go to bad", img: "2"))
        notes.append(Diary(title:"Wonderful day!", text:"Find some money", img: "3"))
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(NotesTableViewController.addNote(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }

    func addNote(sender: AnyObject) {
        notes.insert(Diary(title: "Tap to write title", text: "Empty", img: "0"), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func converDate (date: NSDate) -> String {
        let formatterDate = NSDateFormatter()
        formatterDate.dateStyle = .LongStyle
        if NotesTableViewController.dateType == true
        {
            formatterDate.timeStyle = .ShortStyle
        }
        else if NotesTableViewController.dateType == false
        {
            formatterDate.dateStyle = .ShortStyle
            formatterDate.timeStyle = .NoStyle
        }
        return formatterDate.stringFromDate(date)
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
        return notes.count
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
     let notate = notes[indexPath.row]
     let cellId = "Cell"
     let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
     cell.textLabel?.text = converDate(notate.date)
     cell.detailTextLabel?.text = notate.text
        if notate.img == "0"
        {
        cell.imageView?.image = UIImage(named: "default")
        }
        if notate.img == "1"
        {
            cell.imageView?.image = UIImage(named: "rain_sm")
        }
        if notate.img == "2"
        {
            cell.imageView?.image = UIImage(named: "sunny_sm")
        }
        if notate.img == "3"
        {
            cell.imageView?.image = UIImage(named: "cloudy_sm")
        }
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showDetail"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                var notate = notes[indexPath.row]
                let destinationController = segue.destinationViewController as! DeatilViewController
                destinationController.dateTXT = converDate(notate.date)
                destinationController.notes = notate
                destinationController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
 
        if editingStyle == .Delete {
            notes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    

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
