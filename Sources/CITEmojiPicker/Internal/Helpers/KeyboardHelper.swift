//
//  KeyboardHelper.swift
//  CITEmojiPicker
//
//  Created by Hugo de Groot on 16/06/2022.
//  Copyright © 2022 Coffee IT. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class KeyboardHelper: ObservableObject {
    @Published var height: CGFloat = 0
    @Published var isOpen = false
    
    init() {
        listenForKeyboardNotifications()
    }
    
    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            self.height = keyboardRect.height
            self.isOpen = true
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            self.height = 0
            self.isOpen = false
        }
    }
}
