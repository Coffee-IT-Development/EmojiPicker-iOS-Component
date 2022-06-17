//
//  EmojisByGroup.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation

struct EmojisByGroup: Identifiable, Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case emoji
        case skinToneSupport = "skin_tone_support"
        case name
        case slug
        case unicodeVersion = "unicode_version"
        case emojiVersion = "emoji_version"
        case skinToneSupportUnicodeVersion = "skin_tone_support_unicode_version"
    }
    
    var id = UUID()
    let emoji: String
    let skinToneSupport: Bool
    let name: String
    let slug: String
    let unicodeVersion: String
    let emojiVersion: String
    let skinToneSupportUnicodeVersion: String?
}

typealias EmojiGroups = [String: [EmojisByGroup]]
