//
//  Label+Extension.swift
//  Quranic
//
//  Created by renameme on 2/6/18.
//  Copyright © 2018 TodayPublication. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setDescription(htmlText: String){
        let modifiedFont = "<div style='font-size:\(self.font!.pointSize)px; color:#9B9B9B; font-family:\(self.font!.fontName);'>\(htmlText)</div>"
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .utf16, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        self.attributedText = attrStr
    }
    

    
    func boundingRectForCharacterRange(range: NSRange) -> CGRect? {
        
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.bounds.size)
        textContainer.lineFragmentPadding = 0
        layoutManager.addTextContainer(textContainer)
        
        var glyphRange = NSRange()
        
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
    
    func animateText(text : String){
        let animation: CATransition = CATransition()
        animation.duration = 0.5
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromRight
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.add(animation, forKey: "changeTextTransition")
        self.text = text
    }
    
    func setTextWithHeightLine(lineHeight: CGFloat , attrString :  NSMutableAttributedString) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        attrString.addAttribute(NSAttributedStringKey.font, value: self.font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
    
    func pushTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromTop
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionPush)
    }
    
    func boundingRectForCharacterRange2(range: NSRange) -> CGRect? {
        
        guard let attributedText = attributedText else { return nil }
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        
        layoutManager.addTextContainer(textContainer)
        
        var glyphRange = NSRange()
        
        // Convert the range for glyphs.
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
}

