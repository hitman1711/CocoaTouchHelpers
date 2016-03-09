//
//  String+CTH.swift
//  Pods
//
//  Created by felipowsky on 3/9/16.
//
//

import Foundation

extension String {
    
    private static let cth_emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    
    public var cth_isEmail: Bool {
        get {
            return NSPredicate(format: "SELF MATCHES \(String.cth_emailRegex)").evaluateWithObject(self)
        }
    }
    
    public func cth_trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
    }
    
    public func cth_sanitizeAsFilename() -> String {
        return self.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:"/\\?%*|\"<>")).joinWithSeparator("")
    }
    
}
