//
//  ViewController.swift
//  Test
//
//  Created by huongpv on 12/21/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var linkRange = NSRange()

    @IBOutlet weak var lbTest: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let input = "xyz Substring to detect abc After having several issues with this kind of stuff, using a lot of different librairies, etc... I found an "
        let linkStr = "Substring to detect"
//        let input = "xyz Substring to detect abc"
        
        lbTest.text = input
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(tap:)))
        self.lbTest.addGestureRecognizer(tap)
        self.lbTest.isUserInteractionEnabled = true
        
        
        let attributedString = NSMutableAttributedString(string: input)
    
        guard let range = input.range(of: linkStr)?.nsRange else { return }
        linkRange = range
        
        attributedString.addAttribute(.link, value: linkStr, range: range)
        lbTest.attributedText = attributedString
    }

    @objc func tapLabel(tap: UITapGestureRecognizer) {
        if tap.didTapAttributedTextInLabel(label: lbTest, inRange: linkRange) {
            // Substring tapped
            
            print("Success")
        }
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension Range where Bound == String.Index {
    var nsRange:NSRange {
        return NSRange(location: self.lowerBound.encodedOffset,
                       length: self.upperBound.encodedOffset -
                        self.lowerBound.encodedOffset)
    }
}
