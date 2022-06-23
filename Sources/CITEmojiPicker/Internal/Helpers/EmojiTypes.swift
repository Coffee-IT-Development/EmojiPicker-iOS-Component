//
//  EmojiTypes.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 13/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation
import SwiftUI

enum EmojiTypes: String, Identifiable, CaseIterable {
    case recents = "Recents"
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
        case .recents:
            return Image(systemName: "clock")
        case .smileysAndEmotion:
            return Image.icSmileysAndPeople
        case .animalsAndNature:
            return Image.icAnimalsAndNature
        case .foodAndDrink:
            return Image.icFoodAndDrinks
        case .activities:
            return Image.icActivity
        case .travelAndPlaces:
            return Image.icTravelAndPlaces
        case .objects:
            return Image.icObjects
        case .symbols:
            return Image.icSymbols
        case .flags:
            return Image.icFlags
        }
    }
    
    var lokalisedString: String {
        switch self {
        case .recents:
            return NSLocalizedString("citemojipicker_recents", bundle: .module, comment: "Recents")
        case .smileysAndEmotion:
            return NSLocalizedString("citemojipicker_smileys_and_people", bundle: .module, comment: "Smileys & People")
        case .animalsAndNature:
            return NSLocalizedString("citemojipicker_animals_and_nature", bundle: .module, comment: "Animals & Nature")
        case .foodAndDrink:
            return NSLocalizedString("citemojipicker_food_and_drink", bundle: .module, comment: "Food & Drink")
        case .activities:
            return NSLocalizedString("citemojipicker_activity", bundle: .module, comment: "Activity")
        case .travelAndPlaces:
            return NSLocalizedString("citemojipicker_travel_and_places", bundle: .module, comment: "Travel & Places")
        case .objects:
            return NSLocalizedString("citemojipicker_objects", bundle: .module, comment: "Objects")
        case .symbols:
            return NSLocalizedString("citemojipicker_symbols", bundle: .module, comment: "Symbols")
        case .flags:
            return NSLocalizedString("citemojipicker_flags", bundle: .module, comment: "Flags")
        }
    }
}
