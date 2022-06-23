// Prints out translations from Apple’s glossary files matching text in a supplied English .strings file.
// More detail in the article at https://douglashill.co/localisation-using-apples-glossaries/
import Foundation

let stringsSource = URL(fileURLWithPath: "Scripts/find.strings")
let languageToExplore = "Dutch"

extension Collection {
    /// The only element in the collection, or nil if there are multiple or zero elements.
    var single: Element? { count == 1 ? first! : nil }
}

extension XMLElement {
    func singleChild(withName name: String) -> XMLElement? {
        elements(forName: name).single
    }
}

extension XMLNode {
    var textOfSingleChild: String? {
        guard let singleChild = children?.single, singleChild.kind == .text else {
            return nil
        }
        return singleChild.stringValue
    }
}

struct LocalisationEntry {
    /// The file where the entry was read from.
    let fileURL: URL
    /// The usage description to help with translation.
    let comment: String?
    /// The key to look up this string. This is may be <NO KEY> because some Apple strings files use just whitespace as a key and NSXMLDocument can not read whitespace-only text elements.
    let key: String
    /// The English text.
    let base: String
    /// The localised text.
    let translation: String
}

guard let stringsDictionary = NSDictionary(contentsOf: stringsSource) as? [String: String] else {
    print("No path to an English .strings file supplied. Please set this at the top of the script.")
    exit(1)
}

let volumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: [])!
let germanVolumes = volumes.filter { fileURL -> Bool in
    fileURL.lastPathComponent.contains(languageToExplore)
}
https://developer.apple.com/download/more/
if germanVolumes.isEmpty {
    print("No volumes found matching \(languageToExplore). Please download glossaries from https://developer.apple.com/download/more/ and mount the disk images.")
    exit(1)
}

let localisationEntries = germanVolumes.flatMap { volumeURL -> [LocalisationEntry] in
    let glossaryFilePaths = try! FileManager.default.contentsOfDirectory(at: volumeURL, includingPropertiesForKeys: nil, options: [])

    return glossaryFilePaths.flatMap { fileURL -> [LocalisationEntry] in

        defer {
            print("ℹ️ Read file at \(fileURL.path)")
        }

        let doc = try! XMLDocument(contentsOf: fileURL, options: [.nodePreserveWhitespace])

        return doc.rootElement()!.elements(forName: "File").flatMap { file -> [LocalisationEntry] in
            file.elements(forName: "TextItem").compactMap { textItem -> LocalisationEntry? in
                let translationSet = textItem.singleChild(withName: "TranslationSet")!

                guard let base = translationSet.singleChild(withName: "base")!.textOfSingleChild, let translation = translationSet.singleChild(withName: "tran")!.textOfSingleChild else {
                    return nil
                }

                return LocalisationEntry(
                    fileURL: fileURL,
                    comment: textItem.singleChild(withName: "Description")!.textOfSingleChild,
                    key: textItem.singleChild(withName: "Position")!.textOfSingleChild ?? "<NO KEY>",
                    base: base,
                    translation: translation
                )
            }
        }
    }
}

print("✅ Read \(localisationEntries.count) localisation entries.")

var localisationEntriesByEnglishText: [String: [LocalisationEntry]] = [:]

for entry in localisationEntries {
    var entriesForThisEnglishText = localisationEntriesByEnglishText[entry.base] ?? []
    entriesForThisEnglishText.append(entry)
    localisationEntriesByEnglishText[entry.base] = entriesForThisEnglishText
}

print("✅ There are \(localisationEntriesByEnglishText.count) unique English strings.")

for (key, english) in stringsDictionary {
    guard let possibleEntries = localisationEntriesByEnglishText[english] else {
        print("\n⚠️ No translations found for “\(english)”.")
        continue
    }

    print("\n\(key) = \(english)\n")

    var longestTranslationLength: Int = 0
    var longestKeyLength: Int = 0
    var longestFilenameLength: Int = 0
    for entry in possibleEntries {
        longestTranslationLength = max(longestTranslationLength, entry.translation.count)
        longestKeyLength = max(longestKeyLength, entry.key.count)
        longestFilenameLength = max(longestFilenameLength, entry.fileURL.lastPathComponent.count)
    }

    for entry in possibleEntries {
        print("\(entry.translation.padding(toLength: longestTranslationLength, withPad: " ", startingAt: 0)) \(entry.key.padding(toLength: longestKeyLength, withPad: " ", startingAt: 0)) \(entry.fileURL.lastPathComponent.padding(toLength: longestFilenameLength, withPad: " ", startingAt: 0))")
    }
}

/*
 The MIT License (MIT)
 Copyright 2020 Douglas Hill
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
