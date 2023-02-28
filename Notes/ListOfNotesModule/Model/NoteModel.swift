//
//  NoteModel.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation
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
}
