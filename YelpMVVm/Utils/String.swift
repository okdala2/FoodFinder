//
//  String.swift
//  YelpMVVm
//
//  Created by Dala  on 8/29/21.
//

import UIKit

extension String {
    
    func replaceCharactersFromSet(characterSet: NSCharacterSet, replacementString: String = "") -> String {
        return self.components(separatedBy: characterSet as CharacterSet).joined(separator: replacementString)
    }
    
    func formattedPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
    
    func withoutFormatting() -> String {
        return replaceCharactersFromSet(characterSet: NSCharacterSet.alphanumerics.inverted as NSCharacterSet, replacementString: "")
    }
}
