//
//  EmojiPickerView.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 16/09/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct EmojiPickerView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject private var viewModel = CITEmojiPickerViewModel()
    @StateObject private var keyboardHelper = KeyboardHelper()
    @State private var selectedSection: EmojiTypes = .smileysAndEmotion
    @State private var isSearchingForEmoji = false
    @State private var isPortrait = true
    
    private let gridHorizontalPadding: CGFloat = 16
    private let gridLeadingPadding: CGFloat = 10
    private let didAddEmoji: (EmojisByGroup) -> Void
    
    private var columnAmount: Int {
        isPortrait ? 5 : 3
    }
    private var height: CGFloat {
        isPortrait ? 392 : 259
    }
    private var extraSearchIpadHeight: CGFloat {
        let extraHeight = isPortrait ? 100 : 320
        return keyboardHelper.height + CGFloat(extraHeight)
    }
    private var extraSearchPhoneHeight: CGFloat {
        let extraHeight = isPortrait ? 40 : 100
        return keyboardHelper.height - CGFloat(extraHeight)
    }
    
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
                                            .foregroundColor(CITEmojiPickerColor.textColor)
                                            .padding([.bottom, .leading], 8)
                                        
                                        UIGrid(columns: columnAmount, list: emojiGroup) { emoji in
                                            Text(emoji.emoji)
                                                .font(.system(size: 28))
                                                .padding(.horizontal, isPortrait ? 7 : 1)
                                                .padding(.vertical, isPortrait ? 3 : 0)
                                                .onTapGesture {
                                                    didAddEmoji(emoji)
                                                    viewModel.setRecentEmojis(emoji: emoji.emoji)
                                                }
                                        }
                                    }
                                    .id(emojiType)
                                    .padding(.leading, gridLeadingPadding)
                                    .background(
                                        GeometryReader { proxy in
                                            Color.clear
                                                .anchorPreference(key: EmojiLeadingPreferenceKey.self, value: .leading) { [$0] }
                                        }
                                    )
                                }
                            }
                        }
                    }
                    .overlayPreferenceValue(EmojiLeadingPreferenceKey.self) { anchors in
                        GeometryReader { proxy in
                            // Find the index of the last anchor for which the x value is <= 16
                            // (indicating that it scrolled passed the beginning of the view + the padding)
                            let index = anchors.lastIndex(where: { proxy[$0].x <= gridHorizontalPadding }) ?? 0
                            
                            // Use this index to update the selected number
                            Color.clear
                                .onAppear {
                                    selectedSection = viewModel.availableEmojiTypes[index]
                                }
                                .onChange(of: index) {
                                    selectedSection = viewModel.availableEmojiTypes[$0]
                                }
                        }
                    }
                    
                    EmojiPickerBottomNavigatorView(
                        selectedSection: $selectedSection,
                        availableEmojiTypes: $viewModel.availableEmojiTypes,
                        reader: reader
                    )
                    .padding([.bottom, .horizontal], gridHorizontalPadding)
                }
            } else {
                Color.clear.frame(height: UIDevice.isIPad ? extraSearchIpadHeight : extraSearchPhoneHeight)
            }
        }
        .background(CITEmojiPickerColor.sheetBackground.ignoresSafeArea())
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
            self.isPortrait = scene.interfaceOrientation.isPortrait
        }
    }
    
    public init(didAddEmoji: @escaping (EmojisByGroup) -> Void) {
        self.didAddEmoji = didAddEmoji
    }
}
