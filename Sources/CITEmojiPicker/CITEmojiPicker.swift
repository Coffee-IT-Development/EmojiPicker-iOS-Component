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
    @State private var isPortrait = false
    
    private let gridLeadingPadding: CGFloat = 10
    private let didAddEmoji: (String) -> Void
    private var columnAmount: Int {
        isPortrait ? 5 : 3
    }
    private var height: CGFloat {
        isPortrait ? 392 : 259
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
                                            .foregroundColor(.textColor)
                                            .padding([.bottom, .leading], 8)
                                        
                                        UIGrid(columns: columnAmount, list: emojiGroup) { emoji in
                                            Text(emoji.emoji)
                                                .font(.system(size: 28))
                                                .padding(.horizontal, isPortrait ? 7 : 1)
                                                .padding(.vertical, isPortrait ? 3 : 0)
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
                                            Color.clear
                                                .anchorPreference(key: ItemLeadingPreferenceKey.self, value: .leading) { [$0] }
                                        }
                                    )
                                }
                            }
                        }
                    }
                    .overlayPreferenceValue(ItemLeadingPreferenceKey.self) { anchors in
                        GeometryReader { proxy in
                            // Find the index of the last anchor for which the x value is <= 0
                            // (indicating that it scrolled passed the beginning of the view)
                            let index = anchors.lastIndex(where: { proxy[$0].x <= 16 }) ?? 0
                            
                            // Use this index to update the selected number
                            Color.clear
                                .onAppear {
                                    selectedSection = viewModel.availableEmojiTypes[index]
                                }
                                .onChange(of: index) {
                                    selectedSection = viewModel.availableEmojiTypes[$0]
                                }
                        }
//                        .ignoresSafeArea()
                    }
                    .coordinateSpace(name: "emoji")
                    
                    EmojiPickerBottomNavigatorView(
                        selectedSection: $selectedSection,
                        availableEmojiTypes: $viewModel.availableEmojiTypes,
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
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
            self.isPortrait = scene.interfaceOrientation.isPortrait
            if UIDevice.isIPhone {
                emojiPreferenceKeys = []
            }
        }
    }
    
    public init(didAddEmoji: @escaping (String) -> Void) {
        self.didAddEmoji = didAddEmoji
    }
}

struct ItemLeadingPreferenceKey: PreferenceKey {
    static let defaultValue: [Anchor<CGPoint>] = []
    
    static func reduce(value: inout [Anchor<CGPoint>], nextValue: () -> [Anchor<CGPoint>]) {
        value.append(contentsOf: nextValue())
    }
}
