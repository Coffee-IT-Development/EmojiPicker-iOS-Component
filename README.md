
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

## Maintainer

Actively maintained by Hugo


## Changeslog

#### 1.0.0

- added EmojiPicker
- added search field
