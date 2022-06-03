//
//  CITEmojiPickerViewModel.swift
//  
//
//  Created by Hugo de Groot on 03/06/2022.
//

import SwiftUI

@available(iOS 13.0, *)
public class CITEmojiPickerViewModel: ObservableObject {
    let emojiGroups: EmojiGroups = JSONFileDecoder.decode(fromFile: "emojis-by-group")
}

public enum JSONFileDecoder {
    public static func decode<T: Codable>(fromFile fileName: String) -> T {
        let path = Bundle.main.path(forResource: fileName, ofType: ".json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
