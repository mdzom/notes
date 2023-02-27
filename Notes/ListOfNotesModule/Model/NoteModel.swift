//
//  NoteModel.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

//import Foundation
import RealmSwift

class NoteModel: Object {
    @Persisted var date: Date = Date()
    @Persisted var text: String = ""
    @Persisted private var colorMarkString: String = ColorMark.clear.rawValue
    
    var colorMark: ColorMark {
        get {
            ColorMark(rawValue: colorMarkString) ?? .clear
        }
        set {
            colorMarkString = newValue.rawValue
        }
    }
    
    func createStartNote() -> NoteModel {
        let note = NoteModel()
        note.text = "Добро пожаловать в приложение заметок!\nЗдесь вы можете сохранять свои идеи, планы, списки покупок и многое другое.\nПросто нажмите на кнопку "+" в правом верхнем углу, чтобы создать новую заметку.\nВы также можете нажать на любую из существующих заметок, чтобы отредактировать ее или удалить.\nНадеемся, что вы найдете это приложение полезным и удобным для использования!\n"
        note.colorMark = .yellow
        return note
    }
}
