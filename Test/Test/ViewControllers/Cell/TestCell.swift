//
//  TestCell.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    
    var str: String? {
        didSet {
            textView.delegate = self
            
            // Setup text and link for TextView
            let mutableAttributedString = NSMutableAttributedString(string: str ?? "")
            mutableAttributedString.setAsLink(textToFind: "Apple Store", linkName: "AppleStoreLink")
            mutableAttributedString.setAsLink(textToFind: "1-800-MY-APPLE", linkName: "ApplePhoneNumber")
            mutableAttributedString.setAsLink(textToFind: "find a reseller", linkName: "FindReseller")
            
            textView.attributedText = mutableAttributedString
        }
    }
    
    
}

extension TestCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if URL.absoluteString == "AppleStoreLink" {
            // Handle action tap on AppleStoreLink
            print("Go to Apple Store")
            return true
        } else if URL.absoluteString == "ApplePhoneNumber" {
            // Handle action tap on ApplePhoneNumber
            print("Call to Apple Phone")
            return true
        } else if URL.absoluteString == "FindReseller" {
            // Handle action tap on FindReseller
            print("Find a Reseller")
            return true
        }
        return false
    }
}
