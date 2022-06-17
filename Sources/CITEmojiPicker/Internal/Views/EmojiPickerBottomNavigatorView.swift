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
    private let reader: ScrollViewProxy
    private let emojiImageAssetSize: CGFloat = 16
    private var emojiBackgroundSize: CGFloat {
        emojiImageAssetSize * 2 * CGFloat(EmojiTypes.allCases.count + 2)
    }
    
    var body: some View {
        ZStack {
            ForEach(EmojiTypes.allCases) { emojiType in
                ZStack {
                    if emojiType == selectedSection {
                        Rectangle()
                            .fill(Color.selectedCategoryBackground)
                            .frame(width: emojiImageAssetSize * 2, height: emojiImageAssetSize * 2)
                            .cornerRadius(8)
                            .padding(2)
                    }
                    
                    VStack {
                        emojiType.emojiImage
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.textColor)
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
        .frame(height: 32)
    }
        
    
    init(selectedSection: Binding<EmojiTypes>, reader: ScrollViewProxy) {
        self._selectedSection = selectedSection
        self.reader = reader
    }
}

