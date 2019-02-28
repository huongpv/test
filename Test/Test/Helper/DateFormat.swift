//
//  DateFormat.swift
//  PhuongTAB
//
//  Created by huongpv on 12/11/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import Foundation

struct DateFormat {
    static let baseFormat = "yyyy-MM-dd"
    static let dateTimeFormat2 = "dd/MM/yyyy"
    static let dateTimeFormat1 = "yyyy-MM-dd HH:mm:ss"
    
    static let allFormat: [String] = [dateTimeFormat1, dateTimeFormat2, baseFormat]
}
