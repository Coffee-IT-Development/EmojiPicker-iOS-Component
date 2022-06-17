//
//  CITEmojiPicker.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

public struct CITEmojiPicker: View {
    @ObservedObject private var viewModel = CITEmojiPickerViewModel()
    @ObservedObject private var keyboardHelper = KeyboardHelper()
    @State private var selectedSection: EmojiTypes = .smileysAndEmotion
    @State private var emojiPreferenceKeys: [EmojiPreferenceKey] = []
    @State private var isSearchingForEmoji = false
    
    private let searchEmojiPlaceholder: String
    private let didAddEmoji: (String) -> Void
    private let gridLeadingPadding: CGFloat = 10
    
    public var body: some View {
        VStack {
            SearchEmojiView(
                viewModel: viewModel,
                didAddEmoji: didAddEmoji,
                isSearchingForEmoji: $isSearchingForEmoji,
                keyboardIsOpen: $keyboardHelper.isOpen,
                searchEmojiPlaceholder: searchEmojiPlaceholder
            )
            
            if !keyboardHelper.isOpen {
                ScrollViewReader { reader in
                    ScrollView(.horizontal) {
                        HStack {
                            if let recentEmojis = viewModel.recentEmojis {
                                Text("Recent emojis")
                                    .foregroundColor(.textColor)
                                    .padding([.bottom, .leading], 8)
                                
                                UIGrid(columns: 5, list: recentEmojis) { emoji in
                                    Text(emoji)
                                        .font(.system(size: 28))
                                        .padding(.horizontal, 7)
                                        .padding(.vertical, 3)
                                        .onTapGesture {
                                            didAddEmoji(emoji)
                                        }
                                }
                            }
                            
                            ForEach(EmojiTypes.allCases, id: \.rawValue) { emojiType in
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(emojiType.rawValue)
                                        .foregroundColor(.textColor)
                                        .padding([.bottom, .leading], 8)
                                    
                                    UIGrid(columns: 5, list: viewModel.emojisByGroup[emojiType.rawValue] ?? []) { emoji in
                                        Text(emoji.emoji)
                                            .font(.system(size: 28))
                                            .padding(.horizontal, 7)
                                            .padding(.vertical, 3)
                                            .onTapGesture {
                                                didAddEmoji(emoji.emoji)
                                                viewModel.setRecentEmojis(emoji: emoji)
                                            }
                                    }
                                }
                                .id(emojiType)
                                .padding(.leading, gridLeadingPadding)
                                .background(
                                    GeometryReader { proxy in
                                        if emojiPreferenceKeys.count < EmojiTypes.allCases.count {
                                            let yOffSet = proxy.frame(in: .named("emoji")).minX
                                            let _ = DispatchQueue.main.async {
                                                emojiPreferenceKeys.append(
                                                    EmojiPreferenceKey(
                                                        emojiType: emojiType,
                                                        yOffset: yOffSet
                                                    )
                                                )
                                            }
                                        }
                                        Color.clear
                                    }
                                )
                            }
                        }
                        .background(GeometryReader {
                            Color.clear.preference(
                                key: YOffsetScrollValuePreferenceKey.self,
                                value: -$0.frame(in: .named("emoji")).origin.x - gridLeadingPadding
                            )
                        })
                        .onPreferenceChange(YOffsetScrollValuePreferenceKey.self) { viewYOffsetKey in
                            DispatchQueue.main.async {
                                guard !emojiPreferenceKeys.isEmpty else { return }
                                // This is added because the extra offset is needed for when you click on the EmojiPickerBottomNavigator
                                let extraOffSet: CGFloat = 16
                                for emojiPreferenceKey in emojiPreferenceKeys where emojiPreferenceKey.yOffset <= viewYOffsetKey + extraOffSet {
                                    selectedSection = emojiPreferenceKey.emojiType
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: "emoji")
                
                    EmojiPickerBottomNavigatorView(
                        selectedSection: $selectedSection,
                        reader: reader
                    )
                        .padding([.bottom, .horizontal], 16)
                }
            } else {
                Spacer()
                    .frame(height: UIDevice.isIPad ? keyboardHelper.height + 100 : keyboardHelper.height - 40)
            }
        }
        .background(Color.sheetBackground)
        .frame(maxWidth: .infinity, maxHeight: 392)
    }
    
    public init(searchEmojiPlaceholder: String, didAddEmoji: @escaping (String) -> Void) {
        self.searchEmojiPlaceholder = searchEmojiPlaceholder
        self.didAddEmoji = didAddEmoji
    }
}
