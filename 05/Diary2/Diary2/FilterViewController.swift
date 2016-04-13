//
//  FilterViewController.swift
//  Diary2
//
//  Created by Julian1 on 12.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
 
    @IBOutlet weak var mySegment: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    var diaryNotes: Load?{
        didSet {
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        myTableView.reloadData()
    }
    override func viewWillDisappear(animated: Bool) {
        myTableView.reloadData()
    }
    
    private var displayedNotes: [[Diary]]
    {
        if let newNotes = diaryNotes {
            let sortedRecords = newNotes.sectionNotes.sort({ (firstRecord: Diary, secondRecord: Diary) -> Bool in
                return firstRecord.date.compare(secondRecord.date) == NSComparisonResult.OrderedDescending
            })
            var sectionNotes = [[Diary](), [Diary](), [Diary]()]
            for record in sortedRecords
                {
                    switch(mySegment.selectedSegmentIndex)
                    {
                    case 0:
                    if record.img == .Cloud
                    {
                        if record.isToday() {
                            sectionNotes[0].append(record)
                        } else if record.isYesterday() {
                            sectionNotes[1].append(record)
                        } else if record.isDateThisMonth() {
                            sectionNotes[2].append(record)
                        }
                    }
                    case 1:
                        if record.img == .Rain
                        {
                            if record.isToday() {
                                sectionNotes[0].append(record)
                            } else if record.isYesterday() {
                                sectionNotes[1].append(record)
                            } else if record.isDateThisMonth() {
                                sectionNotes[2].append(record)
                            }
                        }
                    case 2:
                        if record.img == .Sun
                        {
                            if record.isToday() {
                                sectionNotes[0].append(record)
                            } else if record.isYesterday() {
                                sectionNotes[1].append(record)
                            } else if record.isDateThisMonth() {
                                sectionNotes[2].append(record)
                            }
                        }
                    default:
                        break
                    }
            }
            return sectionNotes
        }
        return []
    }
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return displayedNotes.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == displayedNotes.count {
            return 1
        }
        return displayedNotes[section].count
    }

    
    @IBAction func segmentTapAction(sender: AnyObject) {
        myTableView.reloadData()
    }
  

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath)
        
        if let notateCell = cell as? FilterTableViewCell
        {
            let notate = displayedNotes[indexPath.section][indexPath.row]
            notateCell.notateTitle.text = notate.title
            notateCell.notateDate.text = notate.date.formattedRelativeString()
            switch notate.img
            {
            case .Cloud :
                notateCell.notateImg.image = UIImage(named: "cloudy_sm")
            case .Sun :
                notateCell.notateImg.image = UIImage(named: "sunny_sm")
            case .Rain :
                notateCell.notateImg.image = UIImage(named: "rain_sm")
            default :
                break
            }
        }
            return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
