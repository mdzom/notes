//
//  StorageManager.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveNote(_ note: NoteModel) {
        try! realm.write({
            realm.add(note)
        })
    }
    
    static func deleteNote(_ note: NoteModel) {
        try! realm.write({
            realm.delete(note)
        })
    }
}
