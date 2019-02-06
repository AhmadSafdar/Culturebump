//
//  String+Extension.swift
//  Quranic
//
//  Created by renameme on 2/2/18.
//  Copyright © 2018 TodayPublication. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func rangeOf(string: String) -> Range<String.Index>? {
        return self.string.range(of: string)
    }
}

public extension String {
    
    func containsOnlyLetters() -> Bool {
        for chr in self {
            if chr == " " {
                continue
            }
            else if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func getImageName() -> String? {
        if let image = slice(from: "logos%2F", to: ".png") {
            return image
        }
        return String()
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func hexStringToUIColor () -> UIColor {
        let hex = self
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    func components(separatedBy options: EnumerationOptions)-> [String] {
        var components: [String] = []
        enumerateSubstrings(in: startIndex..<endIndex, options: options) { (component, _, _, _) in
            guard let component = component else { return }
            components.append(component)
        }
        return components
    }
    
    func textWidth(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func textHeight(font: UIFont , width : CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func textSize(font: UIFont , height : CGFloat) -> CGSize {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let width  = ceil(boundingBox.width)
        return CGSize(width: width, height: height)
    }
    
    func deleteHTMLTag() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var separateStringByLine : NSArray{
        return self.deleteHTMLTag().components(separatedBy: "|") as NSArray
    }
    
    var separateStringBySpace : NSArray{
        let str = self.removeExtras().deleteHTMLTag()
        let trimmed = str.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        return trimmed.components(separatedBy: " ") as NSArray
    }
    
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    
    func isValidEmail () -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    func removeExtras() -> String{
        var trimmedstr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if let lastchar = trimmedstr.last {
            if [",","\"","‘"].contains(lastchar) {
                trimmedstr = String(trimmedstr.dropLast())
            }
        }
        if let firstChar = trimmedstr.first {
            if [",", ".","\"","‘"].contains(firstChar) {
                trimmedstr = String(trimmedstr.dropFirst())
            }
        }
        return trimmedstr
    }
    
    func removeLastExtras() -> String{
        var trimmedstr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let lastchar = trimmedstr.last {
            if [",",".","'","\"","‘"].contains(lastchar) {
                trimmedstr = String(trimmedstr.dropLast())
            }
        }
        if let firstChar = trimmedstr.first {
            if [",", ".","'","\"","‘"].contains(firstChar) {
                trimmedstr = String(trimmedstr.dropFirst())
            }
        }
        return trimmedstr
    }
    
    func hasSubstring(string: String , options: CompareOptions = .regularExpression) -> Bool {
        let s = self as NSString
        let r = s.range(of: string)
        if r.location != NSNotFound {
            return true
        }
        return false
    }
    
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    
    
    
    
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    
    func verifyUrl (urlString: String) -> Bool {
        //Check for nil
        if !urlString.isEmpty {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func getUrl () -> URL? {
        //Check for nil
        if verifyUrl(urlString: self) {
            return NSURL(string: self) as URL?
        }
        return nil
    }
    
    
    
}
