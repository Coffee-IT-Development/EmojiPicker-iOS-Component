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
    public var body: some View {
        VStack {
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
                                        print(emoji.emoji)
                                    }
                            }
                        }
                        .id(emojiType)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    public init() {
        
    }
}
