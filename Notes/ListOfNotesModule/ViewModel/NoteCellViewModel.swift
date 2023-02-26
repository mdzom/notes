//
//  NoteCellViewModel.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation

class NoteCellViewModel: NoteCellViewModelProtocol {
    
    private var note: NoteModel
    
    var title: String {
        let text = note.text
        let arrayOfLines = text.components(separatedBy: "\n")
        let firstLine = arrayOfLines.first ?? ""
        return firstLine
    }
    
    var text: String {
        let text = note.text
        let arrayOfLines = text.components(separatedBy: "\n")
        if arrayOfLines.count > 1 {
            return arrayOfLines[1]
        } else {
            return ""
        }
    }
    
    var colorMark: ColorMark {
        note.colorMark
    }
    
    init(note: NoteModel) {
        self.note = note
    }
}
