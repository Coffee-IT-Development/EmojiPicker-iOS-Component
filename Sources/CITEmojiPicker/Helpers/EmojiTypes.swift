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
            Image("ic_smileys_and_people")
        case .animalsAndNature:
            Image("ic_smileys_and_people")
        case .foodAndDrink:
            Image("ic_smileys_and_people")
        case .activities:
            Image("ic_smileys_and_people")
        case .travelAndPlaces:
            Image("ic_smileys_and_people")
        case .objects:
            Image("ic_smileys_and_people")
        case .symbols:
            Image("ic_smileys_and_people")
        case .flags:
            Image("ic_smileys_and_people")
        }
    }
}
