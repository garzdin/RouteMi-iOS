//
//  Helper.swift
//  RouteMiApp
//
//  Created by Teodor on 13/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import Foundation

class Formatter {
    static func formatDate(_ rawDate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let parsedDate = formatter.date(from: rawDate) {
            return parsedDate
        } else {
            return nil
        }
    }
    
    static func elapsedTime(_ date: Date) -> String {
        let dayHourMinuteSecond: Calendar.Unit = [.day, .hour, .minute, .second]
        let difference = Calendar.current().components(dayHourMinuteSecond, from: date, to: Date(), options: [])
        
        let seconds = "\(difference.second)s ago"
        let minutes = "\(difference.minute)m ago"
        let hours = "\(difference.hour)h ago"
        let days = "\(difference.day)d ago"
        
        if difference.day > 0 {
            return days
        } else if difference.hour > 0 {
            return hours
        } else if difference.minute > 0 {
            return minutes
        } else if difference.second > 0 {
            return seconds
        } else {
            return ""
        }
    }

}
