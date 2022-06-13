//
//  EmojiTypes.swift
//  
//
//  Created by Hugo de Groot on 13/06/2022.
//

import Foundation
import SwiftUI

enum EmojiTypes: String, Identifiable, CaseIterable {
    case smileysAndEmotion = "Smileys & People"
    case animalsAndNature = "Animals & Nature"
    case foodAndDrink = "Food & Drink"
    case activities = "Activity"
    case travelAndPlaces = "Travel & Places"
    case objects = "Objects"
    case symbols = "Symbols"
    case flags = "Flags"
    
    var id: Self { self }
    
    var emojiImage: Image {
        switch self {
        case .smileysAndEmotion:
            return Image("ic_smileys_and_people")
        case .animalsAndNature:
            return Image("ic_smileys_and_people")
        case .foodAndDrink:
            return Image("ic_smileys_and_people")
        case .activities:
            return Image("ic_smileys_and_people")
        case .travelAndPlaces:
            return Image("ic_smileys_and_people")
        case .objects:
            return Image("ic_smileys_and_people")
        case .symbols:
            return Image("ic_smileys_and_people")
        case .flags:
            return Image("ic_smileys_and_people")
        }
    }
}
