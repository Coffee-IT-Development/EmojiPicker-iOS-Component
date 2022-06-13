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

    var imageAsset: ImageAsset {
        switch self {
        case .smileysAndEmotion:
            return ImageAsset(name: "ic_smileys_and_people")
        case .animalsAndNature:
            return ImageAsset(name: "ic_animals_and_nature")
        case .foodAndDrink:
            return ImageAsset(name: "ic_food_and_drinks")
        case .activities:
            return ImageAsset(name: "ic_activity")
        case .travelAndPlaces:
            return ImageAsset(name: "ic_travel_and_places")
        case .objects:
            return ImageAsset(name: "ic_objects")
        case .symbols:
            return ImageAsset(name: "ic_symbols")
        case .flags:
            return ImageAsset(name: "ic_flags")
        }
    }
}
