//
//  EmojisByGroup.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation

public struct EmojisByGroup: Identifiable, Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case emoji
        case skinToneSupport = "skin_tone_support"
        case name
        case slug
        case unicodeVersion = "unicode_version"
        case emojiVersion = "emoji_version"
        case skinToneSupportUnicodeVersion = "skin_tone_support_unicode_version"
    }
    
    public var id = UUID()
    public let emoji: String
    let skinToneSupport: Bool
    public let name: String
    public let slug: String
    let unicodeVersion: String
    let emojiVersion: String
    let skinToneSupportUnicodeVersion: String?
    
    public var unicode: String {
        var unicode: String = ""
        let unicodes = emoji
            .unicodeScalars // Unicode scalar values of the string
            .map { $0.value }
            .map { String($0, radix: 16, uppercase: true) }
        for code in unicodes {
            unicode += "0x\(code)"
        }
        
        return unicode
    }
    
    init(emoji: String) {
        self.emoji = emoji
        skinToneSupport = false
        name = ""
        slug = ""
        unicodeVersion = ""
        emojiVersion = ""
        skinToneSupportUnicodeVersion = nil
    }
}

typealias EmojiGroups = [String: [EmojisByGroup]]
