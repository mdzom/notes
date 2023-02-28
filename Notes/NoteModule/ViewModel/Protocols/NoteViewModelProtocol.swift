//
//  NoteViewModelProtocol.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation

protocol NoteViewModelProtocol: AnyObject {
    var text: String { get }
    
    func saveNote(text: String)
}
