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

    private let didAddEmoji: (String) -> Void
    private let searchEmojiPlaceholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .foregroundColor(Color.textColor)
                .padding(.leading)
            
            TextField("Search Emoji", text: $viewModel.searchEmojiText)
                .foregroundColor(Color.textColor)
                .keyboardType(.alphabet)
                .disableAutocorrection(true)
        }
        .frame(height: 36)
        .background(Color.searchBarBackground)
        .cornerRadius(10)
        .padding([.top, .horizontal], 16)
        
        if keyboardIsOpen {
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.searchEmojis) { emoji in
                            Text(emoji)
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
        didAddEmoji: @escaping (String) -> Void,
        isSearchingForEmoji: Binding<Bool>,
        keyboardIsOpen: Binding<Bool>,
        searchEmojiPlaceholder: String
    ) {
        self.viewModel = viewModel
        self.didAddEmoji = didAddEmoji
        self._isSearchingForEmoji = isSearchingForEmoji
        self._keyboardIsOpen = keyboardIsOpen
        self.searchEmojiPlaceholder = searchEmojiPlaceholder
    }
}