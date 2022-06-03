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
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
