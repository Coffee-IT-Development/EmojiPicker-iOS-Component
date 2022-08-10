//
//  EmojiPickerBottomNavigatorView.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 13/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import SwiftUI

struct EmojiPickerBottomNavigatorView: View {
    @Binding private var selectedSection: EmojiTypes
    @Binding private var availableEmojiTypes: [EmojiTypes]
    private let reader: ScrollViewProxy
    private let emojiImageAssetSize: CGFloat = 16
    private var emojiBackgroundSize: CGFloat {
        emojiImageAssetSize * 2 * CGFloat(EmojiTypes.allCases.count + 2)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(CITEmojiPickerColor.searchAndCategoriesBackground)
                .frame(maxWidth: .infinity)
            
            HStack(spacing: 8) {
                ForEach(EmojiTypes.allCases) { emojiType in
                    if availableEmojiTypes.contains(emojiType) {
                        ZStack {
                            if emojiType == selectedSection {
                                Rectangle()
                                    .fill(CITEmojiPickerColor.selectedCategoryBackground)
                                    .frame(width: emojiImageAssetSize * 2, height: emojiImageAssetSize * 2)
                                    .cornerRadius(8)
                                    .padding(2)
                            }
                            
                            VStack {
                                emojiType.emojiImage
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(CITEmojiPickerColor.textColor)
                                    .frame(width: emojiImageAssetSize, height: emojiImageAssetSize)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .onTapGesture {
                            reader.scrollTo(emojiType.rawValue, anchor: .leading)
                            selectedSection = emojiType
                        }
                    }
                }
            }
        }
        .frame(height: 32)
    }
    
    init(selectedSection: Binding<EmojiTypes>, availableEmojiTypes: Binding<[EmojiTypes]>, reader: ScrollViewProxy) {
        self._selectedSection = selectedSection
        self._availableEmojiTypes = availableEmojiTypes
        self.reader = reader
    }
}
