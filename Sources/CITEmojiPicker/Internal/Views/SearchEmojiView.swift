//
//  SearchEmojiView.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 16/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct SearchEmojiView: View {
    @ObservedObject private var viewModel: CITEmojiPickerViewModel
    @Binding private var isSearchingForEmoji: Bool
    @Binding private var keyboardIsOpen: Bool

    private let didAddEmoji: (EmojisByGroup) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .foregroundColor(CITEmojiPickerColor.textColor)
                .padding(.leading)
            
            TextField("\(NSLocalizedString("citemojipicker_search", bundle: .module, comment: "Search"))  \(NSLocalizedString("citemojipicker_emoji", bundle: .module, comment: "Emoji"))", text: $viewModel.searchEmojiText)
                .foregroundColor(CITEmojiPickerColor.textColor)
                .keyboardType(.alphabet)
                .disableAutocorrection(true)
        }
        .frame(height: 36)
        .background(CITEmojiPickerColor.searchAndCategoriesBackground)
        .cornerRadius(10)
        .padding([.top, .horizontal], 16)
        
        if keyboardIsOpen {
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.searchEmojis) { emoji in
                            Text(emoji.emoji)
                                .font(.system(size: 28))
                                .padding(.bottom, 12)
                                .onTapGesture {
                                    didAddEmoji(emoji)
                                }
                        }
                    }
                    .frame(alignment: .leading)
                    .padding([.top, .horizontal], 16)
                    .onChange(of: viewModel.searchEmojiText) { _ in
                        viewModel.updateSearchEmojiList()
                        if viewModel.searchEmojiText.isEmpty {
                            isSearchingForEmoji = false
                        } else {
                            isSearchingForEmoji = true
                        }
                    }
                }
            }
        }
    }
    
    init(
        viewModel: CITEmojiPickerViewModel,
        didAddEmoji: @escaping (EmojisByGroup) -> Void,
        isSearchingForEmoji: Binding<Bool>,
        keyboardIsOpen: Binding<Bool>
    ) {
        self.viewModel = viewModel
        self.didAddEmoji = didAddEmoji
        self._isSearchingForEmoji = isSearchingForEmoji
        self._keyboardIsOpen = keyboardIsOpen
    }
}
