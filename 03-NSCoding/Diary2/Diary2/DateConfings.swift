//
//  DateConfings.swift
//  Diary2
//
//  Created by Julian1 on 08.04.16.
//  Copyright © 2016 juliankob.com. All rights reserved.
//

import Foundation

extension NSDate {
    
    func isToday() -> Bool {
        return NSCalendar.currentCalendar().isDateInToday(self)
    }
    
    func isYesterday() -> Bool {
        return NSCalendar.currentCalendar().isDateInYesterday(self)
    }
    
    func daysAgo() -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self, toDate: NSDate(), options: NSCalendarOptions.WrapComponents).day
    }
    
    func formattedRelativeString() -> String {
        let prettyFormatter = NSDateFormatter()
        prettyFormatter.doesRelativeDateFormatting = true
        
        if isToday() {
            if NotesTableViewController.dateType {
                prettyFormatter.timeStyle = .ShortStyle
                prettyFormatter.dateStyle = .ShortStyle
            }
            else {
                prettyFormatter.timeStyle = .ShortStyle
                prettyFormatter.dateStyle = .NoStyle
            }
        } else if isYesterday() {
            prettyFormatter.timeStyle = .NoStyle
            prettyFormatter.dateStyle = .MediumStyle
        } else if daysAgo() < 6 {
            let weekday = NSCalendar.currentCalendar().components(NSCalendarUnit.Weekday, fromDate: self).weekday
            return prettyFormatter.weekdaySymbols[weekday - 1]
        } else {
            if NotesTableViewController.dateType {
                prettyFormatter.timeStyle = .ShortStyle
                prettyFormatter.dateStyle = .ShortStyle
            }
            else {
            prettyFormatter.timeStyle = .NoStyle
            prettyFormatter.dateStyle = .ShortStyle
            }
        }
        
        return prettyFormatter.stringFromDate(self)
    }
    
    func formattedFullString() -> String {
        let fullLengthFormatter = NSDateFormatter()
        fullLengthFormatter.timeStyle = .MediumStyle
        fullLengthFormatter.dateStyle = .MediumStyle
        
        return fullLengthFormatter.stringFromDate(self)
    }
    
    
}