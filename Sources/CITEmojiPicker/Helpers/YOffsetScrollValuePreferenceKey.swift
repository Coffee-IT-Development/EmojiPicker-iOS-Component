//
//  YOffsetScrollValuePreferenceKey.swift
//  
//
//  Created by Hugo de Groot on 13/06/2022.
//

import SwiftUI

struct YOffsetScrollValuePreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
