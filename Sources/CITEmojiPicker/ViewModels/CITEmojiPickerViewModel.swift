//
//  CITEmojiPickerViewModel.swift
//  
//
//  Created by Hugo de Groot on 03/06/2022.
//

import SwiftUI

public class CITEmojiPickerViewModel: ObservableObject {
    let data = Bundle.module.dataFromResource("emojis-by-group")
    public let emojiGroups: EmojiGroups
    
    @Published var emojisByGroup: EmojiGroups
    
    public init() {
        emojiGroups = JSONFileDecoder.decodeEmojis()
        emojisByGroup = filterEmojis()
        print(emojisByGroup)
    }
    
    public func filterEmojis() -> EmojiGroups {
        var emojisByGroup: EmojiGroups = [:]
        var emojiGroup: [EmojisByGroup] = []
        for emojiType in EmojiTypes.allCases {
            for emoji in emojiGroups[emojiType.rawValue] ?? [] where emoji.emoji.isSingleEmoji {
                emojiGroup.append(emoji)
            }
            
            emojisByGroup[emojiType.rawValue] = emojiGroup
            emojiGroup = []
        }
        return emojisByGroup
    }
}

