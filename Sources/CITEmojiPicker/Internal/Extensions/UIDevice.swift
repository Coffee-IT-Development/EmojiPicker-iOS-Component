//
//  UIDevice.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 16/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import UIKit

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
