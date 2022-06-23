
# CITEmojiPicker


## Supported

- iOS 14 and higher


## How to use

Add `CITEmojiPicker` to a view and add a frame height of 392. Then if the view does not automatically ignore the keyboard, also add the .ignoresSafeArea(.keyboard) viewModifier. The searchEmojiPlaceholder should contain the placeholder for the search Emoji field in the correct language.

```
struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            CITEmojiPicker(searchEmojiPlaceholder: "Search Emoji") { emoji in
                print(emoji)
            }
            .frame(height: 392)
        }
        .ignoresSafeArea(.keyboard)
    }
}
    
```

## How to use Localisations

If you want the app to use localisations there's a few steps you have to follow. First add the languages you want to support to the project info under Localizations. Second add a new property to the target info.plist called Localizations. Add the languages you want to support to this array. Only then will the languages be visible. Otherwise it will default to Egnlish. If you want the simulator to show differnt languages make sure to edit the scheme options to set the App Language to the desired language.

The supported languages are:
 - Arabic
 - Catalan
 - CZech
 - Danish
 - German
 - Greek
 - Australian English
 - British English
 - Spanish
 - Latin
 - Finnish
 - Universal French
 - Canadian
 - Hebrew
 - Hindi
 - Croatian
 - Hungarian
 - Indonesian
 - Italian
 - Japanese
 - Korean
 - Malay
 - Norwegian
 - Dutch
 - Polish
 - Brazilian
 - Portuguese
 - Romanian
 - Russian
 - Slovak
 - Swedish
 - Thai
 - Turkish
 - Ukrainian
 - Vietnamese
 - Simplified Chinese
 - Traditional Chinese
 - Hong Kong

## Maintainer

Actively maintained by Hugo


## Changeslog

#### 1.0.0

- added EmojiPicker
- added Search field
- added Recents
- added Localisations
