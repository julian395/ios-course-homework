//
//  Diary.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import Foundation

enum Weather : String {
    case Sun = "Sunny"
    case Rain = "Rainy"
    case Cloud = "Cloudly"
    case Default = "Defaulty"
}

class Diary: NSObject, NSCoding {
    
    var date = NSDate()
    var title: String
    var text: String
    var img : Weather
    
    init?(date: NSDate,title: String, text: String, img: Weather)
    {
        self.date = date
        self.title = title
        self.text = text
        self.img = img
        
        super.init()
        
        if title.isEmpty || text.isEmpty
        {
            return nil
        }
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
    
        let img = Weather(rawValue :(aDecoder.decodeObjectForKey(PropertyKey.imgKey) as! String)) ?? .Default
    
        let date = (aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? NSDate) ?? NSDate()
    
               self.init(date: date,title: title, text: text, img: img)
    }

    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(text, forKey: PropertyKey.textKey)
        aCoder.encodeObject(img.rawValue, forKey: PropertyKey.imgKey)
        aCoder.encodeObject(date, forKey : PropertyKey.dateKey)
    }
    
    
   }

class NotesWithSection {
    var today : [Diary] = []
    var yesterday : [Diary] = []
    var thisWeek : [Diary] = []
    var earlier : [Diary] = []
}