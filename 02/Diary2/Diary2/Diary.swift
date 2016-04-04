//
//  Diary.swift
//  Diary2
//
//  Created by Julian1 on 02.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import Foundation

class Diary {
    var date = NSDate()
    var title: String
    var text: String
    var img : String
   
    
    init (title: String, text: String, img: String) {
        self.title = title
        self.text = text
        self.img = img
        
        
    }
}