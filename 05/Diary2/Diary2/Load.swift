//
//  Load.swift
//  Diary2
//
//  Created by Julian1 on 11.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import Foundation

class Load: NSObject {
    
    var records:[Diary]
    
    override init() {
        records = []
    }
    
    func hardCoded() {
        let d1 = NSDate(timeIntervalSinceNow: -3600*24)
        let d2 = NSDate(timeIntervalSinceNow: -3600*48)
        let d3 = NSDate(timeIntervalSinceNow: -3600*24*10)
        let d4 = NSDate(timeIntervalSinceNow: -3580)
        
        records.append(Diary(date : d1,title:"It's great", text:"Today was a beautiful day!", img: .Default )!)
        records.append(Diary(date : d2,title:"It's great", text:"Today was a beautiful day!", img: .Default )!)
        records.append(Diary(date : d3,title:"It's great", text:"Today was a beautiful day!", img: .Default )!)
        records.append(Diary(date : d4,title:"It's great", text:"Today was a beautiful day!", img: .Default )!)
    }

}