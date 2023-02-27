//
//  ListOfNotesViewModelProtocol.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation

protocol ListOfNotesViewModelProtocol: AnyObject {
    var cellIdentifier: String { get }

    func numberOfRows() -> Int
    func createCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol?
//    func viewModelForSelectedRow() -> NoteViewModelProtocol?
    func viewModelForSelectedRow() -> NoteViewController?
    func selectRow(at indexPath: IndexPath)
    func addNote(completion: @escaping (NoteViewController) -> ())
    func deleteNote(completion: @escaping () -> ())
}
