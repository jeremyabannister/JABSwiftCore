//
//  NSDateExtension.swift
//  JABSwiftCore
//
//  Created by Jeremy Bannister on 7/7/15.
//  Copyright (c) 2015 Jeremy Bannister. All rights reserved.
//

import Foundation

extension Date {
    
    
    // MARK:
    // MARK: Init
    // MARK:
    
    public init(dateString: String) {
        self.init(dateString: dateString, beginning: true)
    }
    
    
    public init(dateString:String, beginning: Bool) {
        
        let components = dateString.components(separatedBy: " ")
        if components.count == 3 {
            let dayAsString = components[1].substring(to: components[1].characters.index(components[1].endIndex, offsetBy: -3))
            var monthIndex = -1
            for i in 0..<Date.months.count {
                let month = Date.months[i]
                if month == components[0] {
                    monthIndex = i
                }
            }
            
            if monthIndex == -1 { // If the month was not found then check against the abbreviated versions of the months
                for i in 0..<Date.months.count {
                    let month = Date.monthsShort[i]
                    if month == components[0] {
                        monthIndex = i
                    }
                }
            }
            
            
            let dateStringFormatter = DateFormatter()
            dateStringFormatter.dateFormat = "yyyy-MM-dd"
            dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
            if let d = dateStringFormatter.date(from: String(format: "%@-%02d-%@", components[2], monthIndex + 1, dayAsString)) {
                if beginning {
                    self = Date.init(timeInterval:0, since: d)
                } else {
                    self = Date.init(timeInterval:86370, since: d)
                }
            } else {
                if beginning {
                    self = Date.init(timeInterval:0, since: Date())
                } else {
                    self = Date.init(timeInterval:86370, since: Date())
                }
            }
            
        } else {
            self = Date.init(timeInterval:0, since: Date())
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
            let components = (Calendar.current as NSCalendar).components(.year, from: self)
            return components.year!
        }
    }
    
    public var yearString: String {
        get {
            return String(format: "%d", year)
        }
    }
    
    
    public var month: Int {
        get {
            let components = (Calendar.current as NSCalendar).components(.month, from: self)
            return components.month!
        }
    }
    
    public var monthString: String {
        get {
            let months = Date.months
            return months[month - 1]
        }
    }
    
    public var monthStringShort: String {
        get {
            let months = Date.monthsShort
            return months[month - 1]
        }
    }
    
    
    public var weekOfYear: Int {
        get {
            let components = (Calendar.current as NSCalendar).components(.weekOfYear, from: self)
            return components.weekOfYear!
        }
    }
    
    public var weekOfYearString: String {
        get {
            return String(format: "%d", weekOfYear)
        }
    }
    
    
    public var day: Int {
        get {
            let components = (Calendar.current as NSCalendar).components(.day, from: self)
            return components.day!
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
            let components = (Calendar.current as NSCalendar).components(.weekday, from: self)
            return components.weekday! - 1
        }
    }
    
    public var dayOfWeekString: String {
        get {
            return Date.daysOfWeek[dayOfWeek]
        }
    }
    
    public var dayOfWeekStringShort: String {
        get {
            return Date.daysOfWeekShort[dayOfWeek]
        }
    }
    
    public var dayOfWeekStringMedium: String {
        get {
            return Date.daysOfWeekMedium[dayOfWeek]
        }
    }
    
    
    public var hour: Int {
        get {
            let components = (Calendar.current as NSCalendar).components(.hour, from: self)
            return components.hour!
        }
    }
    
    public var hourString: String {
        get {
            return String(format: "%d", hour)
        }
    }
    
    
    public var minute: Int {
        get {
            let components = (Calendar.current as NSCalendar).components(.minute, from: self)
            return components.minute!
        }
    }
    
    public var minuteString: String {
        get {
            return String(format: "%d", minute)
        }
    }
    
    
    public var second: Int {
        get {
            let components = (Calendar.current as NSCalendar).components(.second, from: self)
            return components.second!
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
    
    public func numberOfDaysUntil(_ futureDate: Date, inclusive: Bool) -> Int? {
        
        if (futureDate > self) {
            
            let unitFlags = NSCalendar.Unit.day
            let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let components = (calendar as NSCalendar).components(unitFlags, from: self, to: futureDate, options: [])
            
            if let comDay = components.day {
                if inclusive {
                    return comDay + 1
                } else {
                    return components.day
                }
            }
        }
        return nil
    }
    
    
    public func tomorrow () -> Date {
        return self.addingTimeInterval(86400)
    }
    
    public func yesterday () -> Date {
        return self.addingTimeInterval(-86400)
    }

    
}


