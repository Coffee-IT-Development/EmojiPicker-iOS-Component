//
//  SearchEmojiView.swift
//  
//
//  Created by Hugo de Groot on 16/06/2022.
//

import SwiftUI

public struct SearchEmojiView: View {
    @ObservedObject private var viewModel: CITEmojiPickerViewModel
    @Binding private var isSearchingForEmoji: Bool
    private let didAddEmoji: (String) -> Void
    
    public var body: some View {
        HStack {
            Image("ic_magnifying_glass", bundle: .module)
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
        
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.searchEmojis) { emoji in
                        Text(emoji)
                            .font(.system(size: 28))
                            .onTapGesture {
                                didAddEmoji(emoji)
                            }
                    }
                }
                .frame(height: 36, alignment: .leading)
                .padding([.top, .horizontal], viewModel.searchEmojiText.isEmpty ? 0 : 16)
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
    
    init(viewModel: CITEmojiPickerViewModel, didAddEmoji: @escaping (String) -> Void, isSearchingForEmoji: Binding<Bool>) {
        self.viewModel = viewModel
        self.didAddEmoji = didAddEmoji
        self._isSearchingForEmoji = isSearchingForEmoji
    }
}
