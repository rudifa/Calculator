//
//  StringUtil.swift v.0.1.1
//  Swift4Util
//
//  Created by Rudolf Farkas on 22.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

extension String {

    /// Split into [String] of single-character elements
    ///
    /// - Returns: [String]
    func split() -> [String] {
        return self.map { String($0) }
    }


    /// Split into [String] using separator (possibly repeated)
    ///
    /// - Parameter separator: Character
    /// - Returns: [String]
    ///
    /// - Example: "his obsessions" -> ["hi", " ob", "e", "ion"]
    func split(separator: Character) -> [String] {
        return self.split(separator: separator, omittingEmptySubsequences: true).map{ String($0) }
    }


}

extension Array where Element: StringProtocol {

    /// Join [String] elements with ""
    ///
    /// - Returns: String
    func joined() -> String {
        return self.joined(separator: "")
    }
}

