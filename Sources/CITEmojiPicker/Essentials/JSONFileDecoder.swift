//
//  JSONFileDecoder.swift
//  
//
//  Created by Hugo de Groot on 03/06/2022.
//

import Foundation

public enum JSONFileDecoder {
    public static func decodeEmojis<T: Codable>() -> T {
        let data = Bundle.module.dataFromResource("emojis-by-group")
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
        }
        return [String: [EmojisByGroup]]() as! T
    }
}
