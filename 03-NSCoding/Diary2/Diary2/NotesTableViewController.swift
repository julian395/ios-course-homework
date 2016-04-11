//
//  NotesTableViewController.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    var notes = [Diary]()
    static var dateType = true
 
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let savedNotes = loadNotes() {
        notes = notes + savedNotes
        }
        else
        {
        hardCoded()
        }
        if notes.isEmpty
        {
            hardCoded()
        }

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(NotesTableViewController.addNote(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }

    func hardCoded()
    {
        let d1 = NSDate(timeIntervalSinceNow: -3600*24) // yesterday, should be shown as yesterday
        let d2 = NSDate(timeIntervalSinceNow: -3600*48) // 2 days ago, should be shown as day of week
        let d3 = NSDate(timeIntervalSinceNow: -3600*24*10) // 10 days ago, should be shown as date
        let d4 = NSDate(timeIntervalSinceNow: -3580) // 10 days ago, should be shown as date
        notes.append(Diary(date : d1,title:"It's great", text:"Today was a beautiful day!", img: .Default )!)
        notes.append(Diary(date : d2,title:"I'm layzee", text:"It's very hard to study", img: .Rain)!)
        notes.append(Diary(date : d3,title:"Want sleep", text:"I'm go to bad", img: .Sun)!)
        notes.append(Diary(date : d4,title:"Wonderful day!", text:"Find some money", img: .Cloud)!)
    }

    
    func addNote(sender: AnyObject) {
        notes.insert(Diary(date: NSDate(),title: "Tap to write title", text: "Empty", img: .Default)!, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        saveNotes()
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
     cell.textLabel?.text = notate.date.formattedRelativeString()
     cell.detailTextLabel?.text = notate.text
        switch notate.img
        {
        case .Default :
            cell.imageView?.image = UIImage(named: "default")
        case .Rain :
            cell.imageView?.image = UIImage(named: "rain_sm")
        case .Sun :
            cell.imageView?.image = UIImage(named: "sunny_sm")
        case .Cloud :
            cell.imageView?.image = UIImage(named: "cloudy_sm")
        }
               return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        saveNotes()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showDetail"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                var notate = notes[indexPath.row]
                let destinationController = segue.destinationViewController as! DeatilViewController
                destinationController.dateTXT = notate.date.formattedRelativeString()
                destinationController.notes = notate
                destinationController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    //MARK : NSCoding
   
    func saveNotes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(notes, toFile: Diary.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save notes...")
        }
    }
    
    func loadNotes() -> [Diary]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Diary.ArchiveURL.path!) as? [Diary]
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
            saveNotes()
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
