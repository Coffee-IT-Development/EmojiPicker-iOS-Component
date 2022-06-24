//
//  CITEmojiPicker.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 03/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

public struct CITEmojiPicker: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject private var viewModel = CITEmojiPickerViewModel()
    @StateObject private var keyboardHelper = KeyboardHelper()
    @State private var selectedSection: EmojiTypes = .smileysAndEmotion
    @State private var emojiPreferenceKeys: [EmojiPreferenceKey] = []
    @State private var isSearchingForEmoji = false
    @State private var columnAmount = 5
    @State private var height: CGFloat = 392
    @State private var gridLeadingPadding: CGFloat = 10
    @State private var isPortrait = false
    
    private let didAddEmoji: (String) -> Void
    
    public var body: some View {
        VStack {
            SearchEmojiView(
                viewModel: viewModel,
                didAddEmoji: didAddEmoji,
                isSearchingForEmoji: $isSearchingForEmoji,
                keyboardIsOpen: $keyboardHelper.isOpen
            )
            
            if !keyboardHelper.isOpen {
                ScrollViewReader { reader in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(EmojiTypes.allCases, id: \.rawValue) { emojiType in
                                if let emojiGroup = viewModel.emojisByGroup[emojiType.rawValue], !emojiGroup.isEmpty {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(emojiType.lokalisedString)
                                            .foregroundColor(.textColor)
                                            .padding([.bottom, .leading], 8)
                                        
                                        UIGrid(columns: columnAmount, list: emojiGroup) { emoji in
                                            Text(emoji.emoji)
                                                .font(.system(size: 28))
                                                .padding(.horizontal, 7)
                                                .padding(.vertical, 3)
                                                .onTapGesture {
                                                    didAddEmoji(emoji.emoji)
                                                    viewModel.setRecentEmojis(emoji: emoji.emoji)
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
                        emptyEmojiTypes: $viewModel.emptyEmojiTypes,
                        reader: reader
                    )
                    .padding([.bottom, .horizontal], 16)
                }
            } else {
                Spacer()
                    .frame(height: UIDevice.isIPad ? keyboardHelper.height + 100 : keyboardHelper.height - 40)
            }
        }
        .background(Color.sheetBackground.ignoresSafeArea())
        .frame(maxWidth: .infinity)
        .frame(height: height)
//        .onChange(of: sizeClass) { newValue in
//            if newValue == .regular {
//                emojiPreferenceKeys = []
//                columnAmount = 3
//                height = 259
//                gridLeadingPadding = 2
//            } else {
//                emojiPreferenceKeys = []
//                columnAmount = 5
//                height = 392
//                gridLeadingPadding = 10
//            }
//        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
            self.isPortrait = scene.interfaceOrientation.isPortrait
            if UIDevice.isIPhone {
                if isPortrait {
                    emojiPreferenceKeys = []
                    columnAmount = 5
                    height = 392
                } else {
                    emojiPreferenceKeys = []
                    columnAmount = 3
                    height = 259
                }
            }
        }
    }
    
    public init(didAddEmoji: @escaping (String) -> Void) {
        self.didAddEmoji = didAddEmoji
    }
}
