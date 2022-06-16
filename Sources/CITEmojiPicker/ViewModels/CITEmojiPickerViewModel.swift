//
//  CITEmojiPickerViewModel.swift
//  
//
//  Created by Hugo de Groot on 03/06/2022.
//

import SwiftUI

public class CITEmojiPickerViewModel: ObservableObject {
    @Published var emojisByGroup: EmojiGroups = [:]
    @Published var searchEmojis = [String]()
    @Published var searchEmojiText = ""
    
    private let emojiGroups: EmojiGroups
    private var searchEmojiArray = [EmojisByGroup]()
    
    public init() {
        emojiGroups = JSONFileDecoder.decodeEmojis()
        emojisByGroup = filterEmojis()
        fillSearchEmojiList()
    }
    
    func filterEmojis() -> EmojiGroups {
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
    
    func fillSearchEmojiList() {
        var emojiArray = [EmojisByGroup]()
        for emojiType in EmojiTypes.allCases {
            for emoji in emojisByGroup[emojiType.rawValue] ?? [] {
                emojiArray.append(emoji)
            }
        }
        searchEmojiArray = emojiArray
    }
    
    func updateSearchEmojiList(keyboardIsOpen: Bool) {
        if !keyboardIsOpen {
            searchEmojis = [String]()
            searchEmojiText = ""
            return
        }
        
        var searchEmojisList = [String]()
        for emoji in searchEmojiArray {
            if emoji.name.contains(searchEmojiText.lowercased()) {
                searchEmojisList.append(emoji.emoji)
            }
        }
        searchEmojis = searchEmojisList
    }
}

