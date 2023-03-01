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
    
    var color: ColorMark {
        note.colorMark
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
    
    func saveColorMark(_ mark: ColorMark) {
        try! realm.write {
            note.colorMark = mark
            note.date = Date()
        }
    }
}
