//
//  NotesTableViewController.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    static var dateType = false
    
        var diaryNotes: Load?{
        didSet {
            tableView.reloadData()
        }
    }
    
    private var displayedNotes: [[Diary]]
    {
        if let newNotes = diaryNotes {
        let sortedRecords = newNotes.sectionNotes.sort({ (firstRecord: Diary, secondRecord: Diary) -> Bool in
            return firstRecord.date.compare(secondRecord.date) == NSComparisonResult.OrderedDescending
        })
        var sectionNotes = [[Diary](), [Diary](), [Diary](), [Diary]()]
        for record in sortedRecords {
            if record.isToday() {
                sectionNotes[0].append(record)
            } else if record.isYesterday() {
                sectionNotes[1].append(record)
            } else if record.isDateThisMonth() {
                sectionNotes[2].append(record)
            }
        }
        return sectionNotes
    }
        return []
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.reloadData()
        loadNotes()
       

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(NotesTableViewController.addNote(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     
        return displayedNotes.count 
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if section == displayedNotes.count {
            return 1
        }

        return displayedNotes[section].count
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if let notateCell = cell as? SectionTableViewCell
        {
            let notate = displayedNotes[indexPath.section][indexPath.row]
            notateCell.notateTitle.text = notate.title
            notateCell.notateText.text = notate.text
            notateCell.notateDate.text = notate.date.formattedRelativeString()
            switch notate.img
            {
            case .Default :
                notateCell.notateImg.image = UIImage(named: "default")
                notateCell.backgroundColor = .clearColor()
            case .Rain :
                notateCell.notateImg.image = UIImage(named: "rain_sm")
                notateCell.backgroundColor = .whiteColor()
            case .Sun :
                notateCell.notateImg.image = UIImage(named: "sunny_sm")
                notateCell.backgroundColor = .yellowColor()
            case .Cloud :
                notateCell.notateImg.image = UIImage(named: "cloudy_sm")
                notateCell.backgroundColor = .blueColor()
            }

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
                var notate = displayedNotes[indexPath.section][indexPath.row]
                let destinationController = segue.destinationViewController as! DeatilViewController
                destinationController.dateTXT = notate.date.formattedRelativeString()
                destinationController.notes = notate
                destinationController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    //MARK : NSCoding
   
    func saveNotes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(displayedNotes, toFile: Diary.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save notes...")
        }
    }
    
    func addNote(sender: AnyObject) {
        diaryNotes?.sectionNotes.append(Diary(date: NSDate(),title: "Tap to write title", text: "Empty", img: .Default)!)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        saveNotes()
        tableView.reloadData()
    }

    
    func loadNotes() -> [Diary]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Diary.ArchiveURL.path!) as? [Diary]
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0  {
            return "Today"
        }
        if section == 1 {
            return "Yesterday"
        }
        if section == 2 {
            return "Earlier"
        }
        return nil
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {       
            let record = displayedNotes[indexPath.section][indexPath.row]
            if let removeIndex = diaryNotes?.sectionNotes.indexOf(record) {
                diaryNotes?.sectionNotes.removeAtIndex(removeIndex)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            if (displayedNotes[indexPath.section].count == 0) {
                tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .None)
            }
            saveNotes()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
