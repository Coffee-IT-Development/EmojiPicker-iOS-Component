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
    case recents = "recents"
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
}
