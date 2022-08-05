
# CITEmojiPicker


## Supported

- iOS 14 and higher


## How to use

Add `CITEmojiPicker` to a view. Then if the view does not automatically ignore the keyboard, also add the .ignoresSafeArea(.keyboard) viewModifier.
To get the unicode of an emoji use: emoji.unicode
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

## How to use Localisations

If you want the app to use localisations there's a few steps you have to follow. First add the languages you want to support to the project info under Localizations. Second add a new property to the target info.plist called Localizations. Add the languages you want to support to this array. Only then will the languages be visible. Otherwise it will default to English. If you want the simulator to show different languages make sure to edit the scheme options to set the App Language to the desired language.

The supported languages are: Arabic, Catalan, Czech, Danish, German, Greek, English, Australian English, British English, Spanish, Latin, Finnish, Universal French, Canadian, Hebrew, Hindi, Croatian, Hungarian, Indonesian, Italian, Japanese, Korean, Malay, Norwegian, Dutch, Polish, Brazilian Portuguese, Portuguese, Romanian, Russian, Slovak, Swedish, Thai, Turkish, Ukrainian, Vietnamese, Simplified Chinese, Traditional Chinese, Hong Kong

## Maintainer

Actively maintained by Hugo


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
