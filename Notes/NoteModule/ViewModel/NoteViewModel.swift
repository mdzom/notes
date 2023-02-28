//
//  NoteViewModel.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation
import RealmSwift

class NoteViewModel: NoteViewModelProtocol {
    
    private var note: NoteModel
    
    var text: String {
        note.text
    }
    
    init(note: NoteModel) {
        self.note = note
    }
    
    func saveNote(text: String) {
        try! realm.write {
            note.text = text
            note.date = Date()
        }
    }
}
