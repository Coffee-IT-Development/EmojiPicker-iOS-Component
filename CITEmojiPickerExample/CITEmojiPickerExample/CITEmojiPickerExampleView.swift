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
            VStack {
                Image("aroma_logo")
                    .padding(.top, 48)
                
                Text(emoji)
                    .font(.largeTitle)
                    .frame(maxHeight: .infinity)
                
                CITEmojiPicker { emoji in
                    self.emoji = emoji.emoji
                }
            }
            .ignoresSafeArea(.keyboard)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CITEmojiPickerExampleView()
    }
}
