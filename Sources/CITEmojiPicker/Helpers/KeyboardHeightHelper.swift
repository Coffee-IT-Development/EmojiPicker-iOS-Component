//
//  KeyboardHeightHelper.swift
//  
//
//  Created by Hugo de Groot on 16/06/2022.
//

import UIKit
import Foundation

class KeyboardHeightHelper: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
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
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            self.keyboardHeight = 0
        }
    }
}
