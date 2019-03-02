//
//  PickerViewer.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class PickerViewer {
    static func showTextPicker(list: [String],
                               defaultIndex: Int = 0,
                               completion: ((TextPickerResponse?) -> Void)?) {
        VCService.present(type: TextPicker.self, prepare: { picker in
            picker.set(list: list, defaultIndex: defaultIndex)
            picker.didSelectText = { response in
                completion?(response)
            }
        }, animated: false)
    }

    static func showTimePicker(hour: Int, minute: Int, minTime: Date? = nil, maxTime: Date? = nil, completion: ((DateTimePickerTimeResponse?) -> Void)?) {
        VCService.present(type: DateTimePicker.self, prepare: { picker in
            picker.set(type: .time)
            picker.set(hour: hour, minute: minute, minTime: minTime, maxTime: maxTime)
            picker.didSelectTime = { response in
                
            }
        }, animated: false)
    }
    
    static func showDatePicker(date: Date, minDate: Date? = nil, maxDate: Date? = nil, completion: ((DateTimePickerDateResponse?) -> Void)?) {
        VCService.present(type: DateTimePicker.self, prepare: { picker in
            picker.set(type: .date)
            picker.set(date: date, minDate: minDate, maxDate: maxDate)
            picker.didSelectDate = { response in
                completion?(response)
            }
        }, animated: false)
    }
    
    static func showDateTimePicker(date: Date, minDate: Date? = nil, maxDate: Date? = nil, completion: ((DateTimePickerDateTimeResponse?) -> Void)?) {
        VCService.present(type: DateTimePicker.self, prepare: { picker in
            picker.set(type: .dateAndTime)
            picker.set(date: date, minDate: minDate, maxDate: maxDate)
            picker.didSelectDateTime = { response in
                completion?(response)
            }
        }, animated: false)
    }
}
