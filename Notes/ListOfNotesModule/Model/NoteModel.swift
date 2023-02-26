//
//  NoteModel.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation

struct NoteModel {
    var text: String
    var colorMark: ColorMark
    var date: Date
    
    init(text: String, colorMark: ColorMark = .clear, date: Date = Date()) {
        self.text = text
        self.colorMark = colorMark
        self.date = date
    }
    
    func crerateStartNote() -> NoteModel {
        NoteModel(text: "Добро пожаловать в приложение заметок!\nЗдесь вы можете сохранять свои идеи, планы, списки покупок и многое другое.\nПросто нажмите на кнопку "+" в правом верхнем углу, чтобы создать новую заметку.\nВы также можете нажать на любую из существующих заметок, чтобы отредактировать ее или удалить.\nНадеемся, что вы найдете это приложение полезным и удобным для использования!\n",
                  colorMark: .yellow)
    }
}
