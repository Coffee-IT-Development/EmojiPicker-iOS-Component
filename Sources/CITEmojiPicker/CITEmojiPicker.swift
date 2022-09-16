//
//  CITEmojiPicker.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

public struct CITEmojiPicker: View {
    private let didAddEmoji: (EmojisByGroup) -> Void
    
    public var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer()
                EmojiPickerView(didAddEmoji: didAddEmoji)
            }
            .frame(maxHeight: .infinity)
        }
        .ignoresSafeArea(.keyboard)
    }
    
    public init(didAddEmoji: @escaping (EmojisByGroup) -> Void) {
        self.didAddEmoji = didAddEmoji
    }
    
    public init(
        searchAndCategoryBackground: Color = CITEmojiPickerColor.searchAndCategoriesBackground,
        selectedCategoryBackground: Color = CITEmojiPickerColor.selectedCategoryBackground,
        sheetBackground: Color = CITEmojiPickerColor.sheetBackground,
        textColor: Color = CITEmojiPickerColor.textColor,
        didAddEmoji: @escaping (EmojisByGroup) -> Void
    ) {
        CITEmojiPickerColor.searchAndCategoriesBackground = searchAndCategoryBackground
        CITEmojiPickerColor.selectedCategoryBackground = selectedCategoryBackground
        CITEmojiPickerColor.sheetBackground = sheetBackground
        CITEmojiPickerColor.textColor = textColor
        self.didAddEmoji = didAddEmoji
    }
}
