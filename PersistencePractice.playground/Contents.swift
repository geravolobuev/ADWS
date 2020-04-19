import UIKit

struct Note: Codable {
    let title: String
    let text: String
    let timestamp: Date
}

let newNote = Note(title: "Gera", text: "Gera is here!", timestamp: Date())
let secondNote = Note(title: "Bob", text: "Bob is here!", timestamp: Date())
let thirdNote = Note(title: "Joe", text: "Joe is here!", timestamp: Date())

let notes:[Note] = [newNote, secondNote, thirdNote]
//let propertyEncoder = PropertyListEncoder()
//if let encodedNote = try? propertyEncoder.encode(newNote) {
//    print("This is a encoded note: \(encodedNote)")
//
//    let propertyDecoder = PropertyListDecoder()
//    if let decodedNote = try? propertyDecoder.decode(Note.self, from: encodedNote) {
//        print("This is a decoded note: \(decodedNote)")
//    }
//}

let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let archiveURL = documentDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")

let propertyListEncoder = PropertyListEncoder()
let encodedData = try? propertyListEncoder.encode(notes)
try? encodedData?.write(to: archiveURL, options: .noFileProtection)

let propertyListDecoder = PropertyListDecoder()
if let recievedData = try? Data(contentsOf: archiveURL), let decodedNote = try? propertyListDecoder.decode(Array<Note>.self, from: recievedData) {
    print(decodedNote)
}
