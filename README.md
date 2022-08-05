# CITEmojiPicker

[![Swift](https://img.shields.io/badge/Swift-5.6-red?style=flat-square)](https://img.shields.io/badge/Swift-5.6-red?style=flat-square)
[![iOS 13+](https://img.shields.io/badge/iOS-v14+-pink?style=flat-square)](https://img.shields.io/badge/iOS-v14+-pink?style=flat-square)
[![Mirror Repository](https://img.shields.io/badge/Mirror-Repository-pink?style=flat-square)](https://img.shields.io/badge/Mirror-Repository-pink?style=flat-square)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-Compatible-red?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-Compatible-red?style=flat-square)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-@CoffeeIT-blue.svg?style=flat-square)](https://linkedin.com/company/coffee-it)
[![Facebook](https://img.shields.io/badge/Facebook-CoffeeITNL-blue.svg?style=flat-square)](https://www.facebook.com/CoffeeITNL/)
[![Instagram](https://img.shields.io/badge/Instagram-CoffeeITNL-blue.svg?style=flat-square)](https://www.instagram.com/coffeeitnl/)

The CITEmojiPicker package provides an emoji picker view. The colors can be customized.
It includes an option to localise the language.

## Supported
- iOS 14 and higher

## Installation

### SwiftPM

To install the Swift Package, go to Project > Package Dependencies > + > Search or Enter Package URL > Fill in:
```
https://github.com/Coffee-IT-Development/Aroma-iOS-CITEmojiPicker-Component
```


## Usage
Add `CITEmojiPicker` to a view. Then if the view does not automatically ignore the keyboard, also add the .ignoresSafeArea(.keyboard) viewModifier.
To get the unicode of an emoji use: emoji.unicode  
<br>
There is an intializer to use custom colors for the emoji picker. The values for this are: searchAndCategoryBackground, selectedCategoryBackground, sheetBackground, textColor.
One or more of these colors can be overriden with your own custom color. If you want to support dark mode simply add this to your custom color.

```
struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            CITEmojiPicker { emoji in
                print(emoji.emoji)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
    
```

## Customization

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

## How to use Localisations

If you want the app to use localisations there's a few steps you have to follow. First add the languages you want to support to the project info under Localizations. Second add a new property to the target info.plist called Localizations. Add the languages you want to support to this array. Only then will the languages be visible. Otherwise it will default to English. If you want the simulator to show different languages make sure to edit the scheme options to set the App Language to the desired language.

The supported languages are: Arabic, Catalan, Czech, Danish, German, Greek, English, Australian English, British English, Spanish, Latin, Finnish, Universal French, Canadian, Hebrew, Hindi, Croatian, Hungarian, Indonesian, Italian, Japanese, Korean, Malay, Norwegian, Dutch, Polish, Brazilian Portuguese, Portuguese, Romanian, Russian, Slovak, Swedish, Thai, Turkish, Ukrainian, Vietnamese, Simplified Chinese, Traditional Chinese, Hong Kong


## Contact
For questions, ideas or help you can reach us by email at contact@coffeeit.nl.

## Maintainer

Owned by Coffee IT.
Actively maintained by Hugo de Groot


## Changeslog

#### 1.0.3
- added custom color initializer

#### 1.0.2
- added unicodes
- CITEmojiPicker now returns an EmojiByGroup object

#### 1.0.0

- added EmojiPicker
- added Search field
- added Recents
- added Localisations
- added Landscape mode support

## License

Distributed under the MIT License. [See LICENSE](LICENSE.txt) for more information.
