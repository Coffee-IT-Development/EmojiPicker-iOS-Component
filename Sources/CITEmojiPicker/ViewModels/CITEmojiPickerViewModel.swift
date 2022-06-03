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
    
    public init() {
        emojiGroups = JSONFileDecoder.decodeEmojis()
    }
}

