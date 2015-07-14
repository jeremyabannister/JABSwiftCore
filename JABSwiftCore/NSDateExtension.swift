//
//  NSDateExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 7/7/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

extension NSDate: Comparable {
    
    
    public var year: Int {
        get {
            let components = NSCalendar.currentCalendar().components(NSCalendarUnit.YearCalendarUnit, fromDate: self)
            return components.year
        }
    }
    
    public var yearString: String {
        get {
            return String(format: "%d", year)
        }
    }
    
    
    public var month: Int {
        get {
            let components = NSCalendar.currentCalendar().components(NSCalendarUnit.MonthCalendarUnit, fromDate: self)
            return components.month
        }
    }
    
    public var monthString: String {
        get {
            let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
            return months[month - 1]
        }
    }
    
    
    public var weekOfYear: Int {
        get {
            let components = NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYearCalendarUnit, fromDate: self)
            return components.weekOfYear
        }
    }
    
    public var weekOfYearString: String {
        get {
            return String(format: "%d", weekOfYear)
        }
    }
    
    
    public var day: Int {
        get {
            let components = NSCalendar.currentCalendar().components(NSCalendarUnit.DayCalendarUnit, fromDate: self)
            return components.day
        }
    }
    
    public var dayString: String {
        get {
            return String(format: "%d", day)
        }
    }
    
    public var dayStringOrdinal: String {
        get {
            let suffixes = ["st", "nd", "rd", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th", "th", "st"]
            return dayString + suffixes[day - 1]
        }
    }
    
    
    public var dayOfWeek: Int {
        get {
            let components = NSCalendar.currentCalendar().components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: self)
            return components.weekday
        }
    }
    
    public var dayOfWeekString: String {
        get {
            let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            return daysOfWeek[dayOfWeek - 1]
        }
    }
    
    
    public var hour: Int {
        get {
            let components = NSCalendar.currentCalendar().components(NSCalendarUnit.HourCalendarUnit, fromDate: self)
            return components.hour
        }
    }
    
    public var hourString: String {
        get {
            return String(format: "%d", hour)
        }
    }
    
    
    public var minute: Int {
        get {
            let components = NSCalendar.currentCalendar().components(NSCalendarUnit.MinuteCalendarUnit, fromDate: self)
            return components.minute
        }
    }
    
    public var minuteString: String {
        get {
            return String(format: "%d", minute)
        }
    }
    
    
    public var second: Int {
        get {
            let components = NSCalendar.currentCalendar().components(NSCalendarUnit.SecondCalendarUnit, fromDate: self)
            return components.second
        }
    }
    
    public var secondString: String {
        get {
            return String(format: "%d", second)
        }
    }
    

    
}


public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}
