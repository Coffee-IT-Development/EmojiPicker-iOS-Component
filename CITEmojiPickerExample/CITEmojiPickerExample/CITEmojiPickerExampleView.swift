//
//  CITEmojiPickerExampleView.swift
//  CITEmojiPickerExample
//
//  Created by Hugo de Groot on 10/08/2022.
//

import CITEmojiPicker
import SwiftUI

struct CITEmojiPickerExampleView: View {
    @State private var emoji = "😄"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image("aroma_logo")
                    .frame(height: 150)
                    .padding(.vertical, 48)
                
                Text(emoji)
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            CITEmojiPicker { emoji in
                self.emoji = emoji.emoji
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CITEmojiPickerExampleView()
    }
}
