//
//  ViewController.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var notes = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes.append(Diary(title:"It's great", text:"It's great text"))
        notes.append(Diary(title:"It's beautiful", text:"It's beautiful text"))
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let notate = notes[indexPath.row]
        let cellId = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        cell.textLabel?.text = notate.title
        cell.detailTextLabel?.text = notate.text
        
        return cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

