//
//  StringHelpers.swift
//  ZoeLog
//
//  Created by Zoe Van Brunt on 7/10/17.
//  Copyright © 2017 Zoe Van Brunt. All rights reserved.
//

import Foundation

public extension Array {
    var nilIfEmpty: Array? {
        if isEmpty { return nil }
        return self
    }
}

public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

public extension String {
    var trimmed: String { return trimmingCharacters(in: .whitespacesAndNewlines) }
    
    var nilIfEmpty: String? {
        if isEmpty { return nil }
        return self
    }
    
    func ifEmpty(_ alternate: String) -> String { nilIfEmpty ?? alternate }
    
    var isBlank: Bool { trimmed.isEmpty }
    
    var nilIfBlank: String? { isBlank ? self : nil }
    
    func ifBlank(_ alternate: String) -> String { nilIfBlank ?? alternate }
    
    func forEachInstance(of string: String,
                         options: String.CompareOptions = .caseInsensitive,
                         range searchRange: Range<String.Index>? = nil,
                         locale: Locale = .current,
                         _ action: (Range<String.Index>) -> ()) {
        var searchRange = searchRange ?? startIndex..<endIndex
        var rangeOfString: Range<String.Index>? = nil
        repeat {
            rangeOfString = range(of: string,
                                  options: options,
                                  range: searchRange,
                                  locale: locale)
            if let range = rangeOfString {
                action(range)
                searchRange = range.upperBound..<endIndex
            }
        } while rangeOfString != nil
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    var isFirstLetterCapitalized: Bool {
        guard count > 0 else { return false }
        let range = startIndex..<index(after: startIndex)
        let firstLetter = String(self[range])
        return firstLetter == firstLetter.localizedCapitalized
    }
    
    @available(iOS 10.2, *)
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    
    @available(iOS 10.2, *)
    var containsEmoji: Bool { contains { $0.isEmoji } }
    
    @available(iOS 10.2, *)
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
    
    @available(iOS 10.2, *)
    var emojiString: String { emojis.map { String($0) }.reduce("", +) }
    
    @available(iOS 10.2, *)
    var emojis: [Character] { filter { $0.isEmoji } }
    
    @available(iOS 10.2, *)
    var emojiScalars: [UnicodeScalar] { emojis.flatMap { $0.unicodeScalars } }
    
    static var nonBreakingSpace: String { return String(Character.nonBreakingSpace)}
    
}

public extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    @available(iOS 10.2, *)
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    /// Checks if the scalars will be merged into an emoji
    @available(iOS 10.2, *)
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    
    @available(iOS 10.2, *)
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
    
    static var nonBreakingSpace: Character { "\u{00A0}" }
}
