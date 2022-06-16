//
//  KeyboardHelper.swift
//  
//
//  Created by Hugo de Groot on 16/06/2022.
//

import UIKit
import SwiftUI
import Foundation

class KeyboardHelper: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    @Published var keyboardIsOpen = false
    
    init() {
        listenForKeyboardNotifications()
    }
    
    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            self.keyboardHeight = keyboardRect.height
            self.keyboardIsOpen = true
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            self.keyboardHeight = 0
            self.keyboardIsOpen = false
        }
    }
}
