//
//  CITEmojiPickerViewModel.swift
//  
//
//  Created by Hugo de Groot on 03/06/2022.
//

import SwiftUI

public class CITEmojiPickerViewModel: ObservableObject {
    public let emojiGroups: EmojiGroups = JSONFileDecoder.decode(fromFile: "emojis-by-group")
    
    public init() {
        
    }
}

