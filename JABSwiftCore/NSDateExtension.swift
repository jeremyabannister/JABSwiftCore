//
//  NSDateExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 7/7/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

extension NSDate: Comparable {
    
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public convenience init(dateString: String) {
        self.init(dateString: dateString, beginning: true)
    }
    
    
    public convenience init(dateString:String, beginning: Bool) {
        
        let components = dateString.componentsSeparatedByString(" ")
        if components.count == 3 {
            let dayAsString = components[1].substringToIndex(advance(components[1].endIndex, -3))
            var monthIndex = -1
            for i in 0..<NSDate.months.count {
                let month = NSDate.months[i]
                if month == components[0] {
                    monthIndex = i
                }
            }
            
            if monthIndex == -1 { // If the month was not found then check against the abbreviated versions of the months
                for i in 0..<NSDate.months.count {
                    let month = NSDate.monthsShort[i]
                    if month == components[0] {
                        monthIndex = i
                    }
                }
            }
            
            
            let dateStringFormatter = NSDateFormatter()
            dateStringFormatter.dateFormat = "yyyy-MM-dd"
            dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            if let d = dateStringFormatter.dateFromString(String(format: "%@-%02d-%@", components[2], monthIndex + 1, dayAsString)) {
                if beginning {
                    self.init(timeInterval:0, sinceDate:d)
                } else {
                    self.init(timeInterval:86370, sinceDate:d)
                }
            } else {
                if beginning {
                    self.init(timeInterval:0, sinceDate:NSDate())
                } else {
                    self.init(timeInterval:86370, sinceDate:NSDate())
                }
            }
            
        } else {
            self.init(timeInterval:0, sinceDate:NSDate())
        }
    }
    
    
    
    // MARK:
    // MARK: Components
    // MARK:
    
    // MARK: Class
    public static var months: [String] {
        get {
            return ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        }
    }
    
    public static var monthsShort: [String] {
        get {
            return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
        }
    }
    
    public static var daysOfWeek: [String] {
        get {
            return ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        }
    }
    
    public static var daysOfWeekShort: [String] {
        get {
            return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        }
    }
    
    public static var daysOfWeekMedium: [String] {
        get {
            return ["Sun", "Mon", "Tues", "Weds", "Thurs", "Fri", "Sat"]
        }
    }
    
    
    
    // MARK: Instance
    public var fullDateString: String {
        get {
            return String(format: "%@ %@, %@", monthString, dayStringOrdinal, yearString)
        }
    }
    
    public var fullDateStringShort: String {
        get {
            return String(format: "%@ %@, %@", monthStringShort, dayStringOrdinal, yearString)
        }
    }
    
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
            let months = NSDate.months
            return months[month - 1]
        }
    }
    
    public var monthStringShort: String {
        get {
            let months = NSDate.monthsShort
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
            return components.weekday - 1
        }
    }
    
    public var dayOfWeekString: String {
        get {
            return NSDate.daysOfWeek[dayOfWeek]
        }
    }
    
    public var dayOfWeekStringShort: String {
        get {
            return NSDate.daysOfWeekShort[dayOfWeek]
        }
    }
    
    public var dayOfWeekStringMedium: String {
        get {
            return NSDate.daysOfWeekMedium[dayOfWeek]
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
    
    public var millisecond: Int {
        get {
            var integer = 0.0
            let fraction = modf(self.timeIntervalSinceReferenceDate, &integer)
            return Int(fraction * 1000)
        }
    }
    
    
    
    
    // MARK:
    // MARK: Methods
    // MARK:
    
    public func numberOfDaysUntil(futureDate: NSDate, inclusive: Bool) -> Int? {
        
        if futureDate > self {
            
            var unitFlags = NSCalendarUnit.DayCalendarUnit
            if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
                let components = calendar.components(unitFlags, fromDate: self, toDate: futureDate, options: nil)
                
                if inclusive {
                    return components.day + 1
                } else {
                    return components.day
                }
            }
        }
        return nil
    }
    
    
    public func tomorrow () -> NSDate {
        return self.dateByAddingTimeInterval(86400)
    }
    
    public func yesterday () -> NSDate {
        return self.dateByAddingTimeInterval(-86400)
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
