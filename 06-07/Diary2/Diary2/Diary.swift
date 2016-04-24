//
//  Diary.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import Foundation

enum Weather: Int {
    case Sun, Rain, Cloud, Default
}

class Diary: NSObject, NSCoding {
    
    var date = NSDate()
    var title: String?
    var text: String?
    var img : Weather
    
    init?(date: NSDate? = nil,title: String? = nil, text: String? = nil, img: Weather? = nil)
    {
        if let dateUnwrapped = date {
            self.date = dateUnwrapped
        } else {
            self.date = NSDate()
        }

        self.title = title
        self.text = text
        if let weatherUnwrapped = img {
            self.img = weatherUnwrapped
        } else {
            self.img = Weather.Sun
        }
        
        super.init()
        
    }
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("Notes")
    
    struct PropertyKey {
        static let titleKey = "title"
        static let textKey = "text"
        static let imgKey = "img"
        static let dateKey = "date"

    }
    
    func DateString() -> String {
       return date.formattedRelativeString()
    }
    
   required convenience init?(coder aDecoder: NSCoder) {
        let title = (aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String) ?? ""
    
        let text = (aDecoder.decodeObjectForKey(PropertyKey.textKey) as! String) ?? ""
    
       // let img = Weather(rawValue :(aDecoder.decodeObjectForKey(PropertyKey.imgKey) as! Int)) ?? .Default
    
        let date = (aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? NSDate) ?? NSDate()
    
               self.init(date: date,title: title, text: text)
    }
        
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(text, forKey: PropertyKey.textKey)
        aCoder.encodeObject(img.rawValue, forKey: PropertyKey.imgKey)
        aCoder.encodeObject(date, forKey : PropertyKey.dateKey)
    }
    
    func isToday() -> Bool {
        return NSCalendar.currentCalendar().isDateInToday(date)
    }
    
    func isYesterday() -> Bool {
        return NSCalendar.currentCalendar().isDateInYesterday(date)
    }
    
    func isDateThisWeek() -> Bool {
        let calendar = NSDateFormatter().calendar
        let thisWeek = calendar.components([.WeekOfYear, .Year], fromDate: NSDate())
        let createdWeek = calendar.components([.WeekOfYear, .Year], fromDate: date)
        return createdWeek == thisWeek
    }
    
    func isDateThisMonth() -> Bool {
        let calendar = NSDateFormatter().calendar
        let thisMonth = calendar.components([.Month, .Year], fromDate: NSDate())
        let createdMonth = calendar.components([.Month, .Year], fromDate: date)
        return createdMonth == thisMonth
    }
    var eventDate: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.stringFromDate(date).uppercaseString
    }

       
   }

class Load: NSObject {
    
    var sectionNotes:[Diary]
    
    override init() {
        sectionNotes = []
    }
    
    
    func hardCoded() {
        let d1 = NSDate(timeIntervalSinceNow: -3600*24)
        let d2 = NSDate(timeIntervalSinceNow: -3600*48)
        let d3 = NSDate(timeIntervalSinceNow: -3600*24*10)
        let d4 = NSDate(timeIntervalSinceNow: -3580)
        let d5 = NSDate(timeIntervalSinceNow: -3600*24*3)
        let d6 = NSDate(timeIntervalSinceNow: -3600*48*15)
        let d7 = NSDate(timeIntervalSinceNow: -3600*24*11)
        let d8 = NSDate(timeIntervalSinceNow: -3200)
        
        sectionNotes.append(Diary(date : d1,title:"It's great", text:"Today was a beautiful day!", img: .Default )!)
        sectionNotes.append(Diary(date : d2,title:"Bad day", text:"I don't love sun!", img: .Sun )!)
        sectionNotes.append(Diary(date : d3,title:"Nice car", text:"No text", img: .Rain )!)
        sectionNotes.append(Diary(date : d4,title:"Hello world", text:"Hi2all", img: .Cloud)!)
        sectionNotes.append(Diary(date : d5,title:"Fast food", text:"Today was a beautiful day!", img: .Sun )!)
        sectionNotes.append(Diary(date : d6,title:"Swift it's cool", text:"I don't love sun!", img: .Sun )!)
        sectionNotes.append(Diary(date : d7,title:"London is the capital", text:"No text", img: .Rain )!)
        sectionNotes.append(Diary(date : d8,title:"My brother is ill", text:"Hi2all", img: .Cloud )!)
    }
    
}
