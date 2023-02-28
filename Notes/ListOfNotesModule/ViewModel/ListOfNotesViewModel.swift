//
//  ListOfNoteViewModel.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation
import RealmSwift

class ListOfNoteViewModel: ListOfNotesViewModelProtocol {
    
    var cellIdentifier = "kjgh3s456fjfhDfhgEH"
    
    private var selectedIndexPath: IndexPath?
    private let firstRun = "keyBool"
    
    private lazy var listOfNotes: Results<NoteModel> = {
        var value = realm.objects(NoteModel.self)
        if !firstRunCheck() {
            let firstNote = createAWelcomeNote()
            StorageManager.saveNote(firstNote)
            UserDefaults.standard.set(true, forKey: firstRun)
        }
        value = value.sorted(byKeyPath: "date", ascending: false)
        return value
    }()
    
    func numberOfRows() -> Int {
        listOfNotes.count
    }
    
    func createCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = listOfNotes[indexPath.row]
        return NoteCellViewModel(note: note)
    }
    
    func viewModelForSelectedRow() -> NoteViewController? {
        guard let selectedIndexPath else { return nil }
        let note = listOfNotes[selectedIndexPath.row]
        let viewModel = NoteViewModel(note: note)
        let controller = NoteViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    func selectRow(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    func addNote(completion: @escaping (NoteViewController) -> ()) {
        let newNote = NoteModel()
        StorageManager.saveNote(newNote)
        let viewModel = NoteViewModel(note: newNote)
        let controller = NoteViewController()
        controller.viewModel = viewModel
        completion(controller)
    }
    
    func deleteNote(completion: @escaping () -> ()) {
        guard let selectedIndexPath else { return }
        let note = listOfNotes[selectedIndexPath.row]
        StorageManager.deleteNote(note)
        completion()
    }
    
    func lastNoteCheck(completion: @escaping (IndexPath) -> ()) {
        guard let first = listOfNotes.first else { return }
        if first.text == "" {
            let indexPath = IndexPath(row: 0, section: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                StorageManager.deleteNote(first)
                completion(indexPath)
            }
        }
    }
    
    private func firstRunCheck() -> Bool {
        UserDefaults.standard.bool(forKey: firstRun)
    }
    
    private func createAWelcomeNote() -> NoteModel {
        let note = NoteModel()
        note.text = "Добро пожаловать в приложение заметок!\nЗдесь вы можете сохранять свои идеи, планы, списки покупок и многое другое.\nПросто нажмите на кнопку "+" в правом верхнем углу, чтобы создать новую заметку.\nВы также можете нажать на любую из существующих заметок, чтобы отредактировать ее или удалить.\nНадеемся, что вы найдете это приложение полезным и удобным для использования!\n"
        note.colorMark = .yellow
        return note
    }
}
