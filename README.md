[![Coffee IT - iOS Aroma Emoji Picker Component](https://coffeeit.nl/wp-content/uploads/2022/08/Aroma_Emoji_Picker_iOS.png)](https://coffeeit.nl/)

[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-Compatible-brightgreen?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-Compatible-brightgreen?style=flat-square)
[![Swift 5.6](https://img.shields.io/badge/Swift-5.6-brightgreen?style=flat-square)](https://img.shields.io/badge/Swift-5.6-brightgreen?style=flat-square)
[![iOS v14+](https://img.shields.io/badge/iOS-v14+-brightgreen?style=flat-square)](https://img.shields.io/badge/iOS-v14+-brightgreen?style=flat-square)
[![Mirror Repository](https://img.shields.io/badge/Mirror-Repository-brightgreen?style=flat-square)](https://img.shields.io/badge/Mirror-Repository-brightgreen?style=flat-square)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](LICENSE.md)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-CoffeeIT-blue.svg?style=flat-square)](https://linkedin.com/company/coffee-it)
[![Facebook](https://img.shields.io/badge/Facebook-CoffeeITNL-blue.svg?style=flat-square)](https://www.facebook.com/CoffeeITNL/)
[![Instagram](https://img.shields.io/badge/Instagram-CoffeeITNL-blue.svg?style=flat-square)](https://www.instagram.com/coffeeitnl/)
[![Twitter](https://img.shields.io/badge/Twitter-CoffeeITNL-blue.svg?style=flat-square)](https://twitter.com/coffeeitnl)

The iOS Aroma EmojiPicker package provides an emoji picker with support light and dark mode and customizable colors.

<p float="left">
<img src="https://media1.giphy.com/media/0C9RXsTXiTNkN1WZW0/giphy.gif" width="200">
</p>

## ⚡ Installation
This component requires minimum __iOS 14__.

### 🔨 SwiftPM
To install the Swift Package, go to Project > Package Dependencies > + > Search or Enter Package URL > Fill in:
```
https://github.com/Coffee-IT-Development/EmojiPicker-iOS-Component
```

## 📖 Usage
Add `CITEmojiPicker` to a view. Then if the view does not automatically ignore the keyboard, also add the .ignoresSafeArea(.keyboard) viewModifier.
To get the unicode of an emoji use: emoji.unicode  
<br>
There is an intializer to use custom colors for the emoji picker. One or more of the colors used in the package can be overriden with your own custom color. If you want to support dark mode simply add this to your custom color.

```swift
import CITEmojiPicker
import SwiftUI

struct CITEmojiPickerExampleView: View {
    @State private var emoji = "😄"
    
    var body: some View {
        VStack {
            Text(emoji)
                .frame(maxHeight: .infinity)
                
            CITEmojiPicker { emoji in
                self.emoji = emoji.emoji
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
    
```

## ⚙️ Customisation
```swift
/// The background color of the search bar and the category bar.
public var searchAndCategoryBackground: Color

/// The background color of the selected category within the pincode cells.
public var selectedCategoryBackground: Color

/// The background color of the emoji picker.
public var sheetBackground: Color

/// The color of the text in the search bar and the category names.
public var textColor: Color

```

## 🔗 Related publications

- [EmojiPicker for Android](https://github.com/Coffee-IT-Development/EmojiPicker-Android-Component)

Look at our other repositories on our [GitHub account](https://github.com/orgs/Coffee-IT-Development/repositories).

## ✏️ Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md).
`CITBottomSheet` adheres to [Semantic Versioning](https://semver.org/).

## 📧 Contact
Do you have questions, ideas or need help? Send us an email at contact@coffeeit.nl.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://global-uploads.webflow.com/605a171ee93af49275331843/623b23cdea80a92703e61b42_Logo_black_1.svg" width="100">
  <source media="(prefers-color-scheme: light)" srcset="https://coffeeit.nl/wp-content/uploads/2016/09/logo_dark_small_new.png" width="100">
  <img alt="CoffeeIT logo" src="https://coffeeit.nl/wp-content/uploads/2016/09/logo_dark_small_new.png" width="100">
</picture>

## ⚠️ License

Distributed under the MIT License. [See LICENSE](LICENSE.md) for more information.
