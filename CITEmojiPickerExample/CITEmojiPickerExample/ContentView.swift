//
//  ContentView.swift
//  CITEmojiPickerExample
//
//  Created by Hugo de Groot on 10/08/2022.
//

import CITEmojiPicker
import SwiftUI

struct ContentView: View {
    @State private var emoji = "😄"
    
    var body: some View {
            VStack {
                Text(emoji)
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
        ContentView()
    }
}
