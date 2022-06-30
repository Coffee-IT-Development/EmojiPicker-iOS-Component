//
//  CITEmojiPickerViewModel.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

class CITEmojiPickerViewModel: ObservableObject {
    @Published var emojisByGroup: EmojiGroups = [EmojiTypes.recents.rawValue:[]]
    @Published var searchEmojis = [String]()
    @Published var recentEmojis: [String]? = []
    @Published var searchEmojiText = ""
    @Published var availableEmojiTypes = [EmojiTypes]()
    
    private let emojiGroups: EmojiGroups
    private var searchEmojiArray = [EmojisByGroup]()
    private let recentEmojisKey = "nl.coffeeit.aroma.citemojipicker.recent_emojis"
    private let userDefaults = UserDefaults.standard
    
    init() {
        emojiGroups = JSONFileDecoder.decodeEmojis()
        filterEmojis()
//        fillSearchEmojiList()
        getRecentEmojis()
//        fillAvailableEmojiTypes()
    }
    
    private func filterEmojis() {
        var emojisByGroup: EmojiGroups = [:]
        var searchEmojiArray = [EmojisByGroup]()
        var emojiGroup: [EmojisByGroup] = []
        for emojiType in EmojiTypes.allCases {
            for emoji in emojiGroups[emojiType.rawValue] ?? [] where emoji.emoji.isSingleEmoji {
                emojiGroup.append(emoji)
                searchEmojiArray.append(emoji)
            }
            
            availableEmojiTypes.append(emojiType)
            emojisByGroup[emojiType.rawValue] = emojiGroup
            emojiGroup = []
        }
    }
    
    private func fillSearchEmojiList() {
        var emojiArray = [EmojisByGroup]()
        for emojiType in EmojiTypes.allCases {
            for emoji in emojisByGroup[emojiType.rawValue] ?? [] {
                emojiArray.append(emoji)
            }
        }
        searchEmojiArray = emojiArray
    }
    
    private func getRecentEmojis() {
        recentEmojis = userDefaults.object(forKey: recentEmojisKey) as? [String]
        var recentEmojisByGroup = [EmojisByGroup]()
        guard let recentEmojis = recentEmojis else {
            return
        }
        
        for emoji in recentEmojis {
            recentEmojisByGroup.append(EmojisByGroup(emoji: emoji))
        }
        emojisByGroup.updateValue(recentEmojisByGroup, forKey: EmojiTypes.recents.rawValue)
    }
    
    func setRecentEmojis(emoji: String) {
        guard let _ = recentEmojis else {
            recentEmojis = [emoji]
            userDefaults.set(recentEmojis, forKey: recentEmojisKey)
            return
        }
        
        if let index = recentEmojis?.firstIndex(of: emoji) {
            recentEmojis?.remove(at: index)
        }
        
        recentEmojis?.insert(emoji, at: 0)
        
        
        if recentEmojis?.count ?? 0 > 30 {
            recentEmojis?.removeLast()
        }
        
        userDefaults.set(recentEmojis, forKey: recentEmojisKey)
    }
    
    func updateSearchEmojiList() {
        var searchEmojisList = [String]()
        for emoji in searchEmojiArray {
            if emoji.name.contains(searchEmojiText.lowercased()) {
                searchEmojisList.append(emoji.emoji)
            }
        }
        searchEmojis = searchEmojisList
    }
    
    private func fillAvailableEmojiTypes() {
        for emojiType in EmojiTypes.allCases {
            if let emojiGroup = emojisByGroup[emojiType.rawValue], !emojiGroup.isEmpty {
                availableEmojiTypes.append(emojiType)
            }
        }
    }
}

