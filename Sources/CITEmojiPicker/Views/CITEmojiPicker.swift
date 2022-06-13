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
            Text("Hello World!")
                .foregroundColor(.textColor)
            
            let _ = print(viewModel.emojisByGroup)
        }
        .frame(width: 200, height: 200)
    }
    
    public init() {
        
    }
}
