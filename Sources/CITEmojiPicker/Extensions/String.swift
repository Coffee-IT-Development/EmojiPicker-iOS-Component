//
//  String.swift
//  
//
//  Created by Hugo de Groot on 13/06/2022.
//

import Foundation

extension String: Identifiable {
    public var id: Int {
        return hash
    }
    
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    var containsEmoji: Bool { contains { $0.isEmoji } }
}
