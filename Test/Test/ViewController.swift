//
//  ViewController.swift
//  Test
//
//  Created by huongpv on 12/21/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let textView: UITextView = {
        let textView = UITextView()
        
        // Setup UI for TextView
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        
        // Setup text and link for TextView
        let mutableAttributedString = NSMutableAttributedString(string: "More ways to shop: Visit an Apple Store, call 1-800-MY-APPLE, or find a reseller.")
        mutableAttributedString.setAsLink(textToFind: "Apple Store", linkName: "AppleStoreLink")
        mutableAttributedString.setAsLink(textToFind: "1-800-MY-APPLE", linkName: "ApplePhoneNumber")
        mutableAttributedString.setAsLink(textToFind: "find a reseller", linkName: "FindReseller")
        
        textView.attributedText = mutableAttributedString
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 200)
        textView.delegate = self
        view.addSubview(textView)
    }
}

extension NSMutableAttributedString {
    func setAsLink(textToFind:String, linkName:String) {
        let foundRange = mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            addAttribute(NSAttributedString.Key.link, value: linkName, range: foundRange)
        }
    }
}

extension ViewController: UITextViewDelegate {
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
