//
//  CITEmojiPicker.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

public struct CITEmojiPicker: View {
    @ObservedObject public var viewModel = CITEmojiPickerViewModel()
    @State var selectedSection: EmojiTypes = .smileysAndEmotion
    @State var emojiPreferenceKeys: [EmojiPreferenceKey] = []
    @State var searchEmojiTextfieldInput = ""
    @State var isSearchingForEmoji = false
    private let didAddEmoji: (String) -> Void
    
    public var body: some View {
        VStack {
            SearchEmojiView(
                viewModel: viewModel,
                didAddEmoji: didAddEmoji,
                isSearchingForEmoji: $isSearchingForEmoji
            )
            
            if !isSearchingForEmoji {
                ScrollViewReader { reader in
                    ScrollView(.horizontal) {
                        HStack {
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
                                            }
                                    }
                                }
                                .id(emojiType)
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
                                value: -$0.frame(in: .named("emoji")).origin.x
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
                
                    EmojiPickerBottomNavigatorView(selectedSection: $selectedSection, reader: reader)
                        .padding(.horizontal, 16)
                }
            } else {
                Spacer()
            }
        }
        .background(Color.sheetBackground)
        .frame(maxWidth: .infinity, maxHeight: 385)
    }
    
    public init(didAddEmoji: @escaping (String) -> Void) {
        self.didAddEmoji = didAddEmoji
    }
}
