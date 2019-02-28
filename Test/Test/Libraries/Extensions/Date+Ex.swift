//
//  Date+Ex.swift
//  PhuongTAB
//
//  Created by huongpv on 12/11/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import Foundation

extension Date {
    static func dateWithAllFormat(dateStr: String, formatDate: String? = nil) -> Date? {
        if let format = formatDate {
            return Date.dateBy(string: dateStr, format: format)
        }
        
        let formats = DateFormat.allFormat
        for fomat in formats {
            if let dateWithFormat = Date.dateBy(string: dateStr, format: fomat) {
                return dateWithFormat
            }
        }
        return nil
    }
}
