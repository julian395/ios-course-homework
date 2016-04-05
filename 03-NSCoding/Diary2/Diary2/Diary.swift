//
//  Diary.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import Foundation

class Diary: NSObject, NSCoding {
    
    var date = NSDate()
    var title: String
    var text: String
    var img : String
   
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("Notes")
    
    struct PropertyKey {
        static let titleKey = "title"
        static let textKey = "text"
        static let imgKey = "img"
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(text, forKey: PropertyKey.textKey)
        aCoder.encodeObject(img, forKey: PropertyKey.imgKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let text = aDecoder.decodeObjectForKey(PropertyKey.textKey) as! String
        let img = aDecoder.decodeObjectForKey(PropertyKey.imgKey) as! String

        self.init(title: title, text: text, img: img)
    }


    
    init?(title: String, text: String, img: String)
    {
        self.title = title
        self.text = text
        self.img = img
        
        super.init()
        
        if title.isEmpty || text.isEmpty
        {
        return nil
        }
    }
}