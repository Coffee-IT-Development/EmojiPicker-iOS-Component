//
//  EmojiLeadingPreferenceKey.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 13/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct EmojiLeadingPreferenceKey: PreferenceKey {
    static let defaultValue: [Anchor<CGPoint>] = []
    
    static func reduce(value: inout [Anchor<CGPoint>], nextValue: () -> [Anchor<CGPoint>]) {
        value.append(contentsOf: nextValue())
    }
}
