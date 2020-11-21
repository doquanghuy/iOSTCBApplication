//
//  String+AsWord.swift
//  FastMobile
//
//  Created by duc on 9/19/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

extension String {
    var asWord: String? {
        guard let number = Int(self.replacingOccurrences(of: ",", with: "")) else {
            return nil
        }
        return number.asWord
    }
}

extension StringProtocol {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}
