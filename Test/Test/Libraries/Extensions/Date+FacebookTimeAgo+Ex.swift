//
//  Date+FacebookTimeAgo+Ex.swift
//  Test
//
//  Created by huongpv on 3/1/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

extension Date {
    private var SECOND: Int { return 1 }
    private var MINUTE: Int { return SECOND * 60 }
    private var HOUR: Int { return MINUTE * 60 }
    private var DAY: Int { return HOUR * 24 }
    private var WEEK: Int { return DAY * 7 }
    private var MONTH: Int { return DAY * 31 }
    private var YEAR: Double { return Double(DAY) * 365.24 }
    
    /*
     Datetime String Formatted As Time Ago
     Takes in a datetime string and returns the Time Ago date format
     */
    func formattedAsTimeAgoWith(string: String) -> String {
        //http://stackoverflow.com/questions/10026714/ios-converting-a-date-received-from-a-mysql-server-into-users-local-time
        //If this is not in UTC, we don't have any knowledge about
        //which tz it is. MUST BE IN UTC.
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: string) else { return "" }
        
        return date.formattedAsTimeAgo()
    }
    
    /*
     Formatted As Time Ago
     Returns the date formatted as Time Ago (in the style of the mobile time ago date formatting for Facebook)
     */
    func formattedAsTimeAgo() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        let secondsSince = Int(now.timeIntervalSince(self))
        
        //Should never hit this but handle the future case
        if (secondsSince < 0) {
            return formatInFuture()
        }
        
        // < 1 minute = "Just now"
        if (secondsSince < MINUTE) {
            return formatJustNow()
        }
        
        // < 1 hour = "x minutes ago"
        if(secondsSince < HOUR) {
            return formatMinutesAgo(secondsSince: secondsSince)
        }
        
        // Today = "x hours ago"
        if calendar.isDateInToday(self) {
            return formatAsToday(secondsSince: secondsSince)
        }
        
        // Yesterday = "Yesterday at 1:28 PM"
        if calendar.isDateInYesterday(self) {
            return formatAsYesterday()
        }
        
        // < Last 7 days = "Friday at 1:48 AM"
        if isLastWeek(secondsSince: secondsSince) {
            return formatAsLastWeek()
        }
        
        // < Last 30 days = "March 30 at 1:14 PM"
        if isLastMonth(secondsSince: secondsSince) {
            return formatAsLastMonth()
        }
        
        // < 1 year = "September 15"
        if isLastYear(secondsSince: secondsSince) {
            return formatAsLastYear()
        }
        
        // Anything else = "September 9, 2011"
        return formatAsOther()
    }
    
    
    /*
     ========================== Date Comparison Methods ==========================
     */
    
    /*
     Is Last Week
     We want to know if the current date object is the first occurance of
     that day of the week (ie like the first friday before today
     - where we would colloquially say "last Friday")
     ( within 6 of the last days)
     
     TODO: make this more precise (1 week ago, if it is 7 days ago check the exact date)
     */
    private func isLastWeek(secondsSince: Int) -> Bool {
        return secondsSince < WEEK
    }
    
    /*
     Is Last Month
     Previous 31 days?
     TODO: Validate on fb
     TODO: Make last day precise
     */
    private func isLastMonth(secondsSince: Int) -> Bool {
        return secondsSince < MONTH
    }
    
    /*
     Is Last Year
     TODO: Make last day precise
     */
    private func isLastYear(secondsSince: Int) -> Bool {
        return Double(secondsSince) < YEAR
    }
    
    
    /*
     ========================== Formatting Methods ==========================
     */
    
    // Future
    private func formatInFuture() -> String {
        return "Trong tương lai"
    }
    
    // Just now
    private func formatJustNow() -> String {
        return "Bây giờ"
    }
    
    // < 1 hour = "x minutes ago"
    private func formatMinutesAgo(secondsSince: Int) -> String {
        //Convert to minutes
        let minutesSince = secondsSince / MINUTE
        
        //Handle Plural
        if (minutesSince == 1) {
            return "1 phút trước"
        } else {
            return "\(minutesSince) phút trước"
        }
    }
    
    // Today = "x hours ago"
    private func formatAsToday(secondsSince: Int) -> String {
        //Convert to hours
        let hoursSince = secondsSince / HOUR
        
        //Handle Plural
        if (hoursSince == 1) {
            return "1 giờ trước"
        } else {
            return "\(hoursSince) giờ trước"
        }
    }
    
    // Yesterday = "Yesterday at 1:28 PM"
    private func formatAsYesterday() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "h:mm a"
        return "Hôm qua lúc \(formatter.string(from: self))"
    }
    
    // < Last 7 days = "Friday at 1:48 AM"
    private func formatAsLastWeek() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEEE 'lúc' h:mm a"
        return formatter.string(from: self)
    }
    
    // < Last 30 days = "March 30 at 1:14 PM"
    private func formatAsLastMonth() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMMM 'lúc' h:mm a"
        return formatter.string(from: self)
    }
    
    // < 1 year = "September 15"
    private func formatAsLastYear() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: self)
    }
    
    // Anything else = "September 9, 2011"
    private func formatAsOther() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d LLLL yyyy"
        return formatter .string(from: self)
    }
    
}
