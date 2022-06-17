//
//  CITEmojiPickerViewModel.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

class CITEmojiPickerViewModel: ObservableObject {
    @Published var emojisByGroup: EmojiGroups = ["Recents":[]]
    @Published var searchEmojis = [String]()
    @Published var recentEmojis: [String]? = []
    @Published var searchEmojiText = ""
    
    private let emojiGroups: EmojiGroups
    private var searchEmojiArray = [EmojisByGroup]()
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        emojiGroups = JSONFileDecoder.decodeEmojis()
        emojisByGroup = filterEmojis()
        fillSearchEmojiList()
        getRecentEmojis()
    }
    
    private func filterEmojis() -> EmojiGroups {
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
    
    private func fillSearchEmojiList() {
        var emojiArray = [EmojisByGroup]()
        for emojiType in EmojiTypes.allCases {
            for emoji in emojisByGroup[emojiType.rawValue] ?? [] {
                emojiArray.append(emoji)
            }
        }
        searchEmojiArray = emojiArray
    }
    
    func getRecentEmojis() {
        recentEmojis = userDefaults.object(forKey: "RECENT_EMOJIS_KEY") as? [String]
        var recentEmojisByGroup = [EmojisByGroup]()
        guard let recentEmojis = recentEmojis else {
            return
        }
        
        for emoji in recentEmojis {
            recentEmojisByGroup.append(EmojisByGroup(emoji: emoji))
        }
        print(recentEmojisByGroup)
        emojisByGroup.updateValue(recentEmojisByGroup, forKey: "Recents")
    }
    
    func setRecentEmojis(emoji: String) {
        guard let _ = recentEmojis else {
            recentEmojis = [emoji]
            userDefaults.set(recentEmojis, forKey: "RECENT_EMOJIS_KEY")
            return
        }
        
        if let index = recentEmojis?.firstIndex(of: emoji) {
            recentEmojis?.remove(at: index)
        }
        
        recentEmojis?.insert(emoji, at: 0)
        
        
        if recentEmojis?.count ?? 0 > 30 {
            recentEmojis?.removeLast()
        }
        
        userDefaults.set(recentEmojis, forKey: "RECENT_EMOJIS_KEY")
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
}

