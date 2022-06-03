//
//  CITEmojiPickerViewModel.swift
//  
//
//  Created by Hugo de Groot on 03/06/2022.
//

import SwiftUI

public class CITEmojiPickerViewModel: ObservableObject {
    public let emojiGroups: EmojiGroups = JSONFileDecoder.decode(fromFile: "emojis-by-group")
    
    public init() {
        
    }
}

public enum JSONFileDecoder {
    public static func decode<T: Codable>(fromFile fileName: String) -> T {
        guard let path = Bundle.main.path(forResource: fileName, ofType: ".json") else { return }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
