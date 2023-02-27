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
    
    
    //    //del:!!!!
    //    private var listOfNotes: [NoteModel] = {
    //        let  note1 = NoteModel()
    //        note1.text = "Важно помнить, что путь к успеху не всегда прямой.\nИногда нам нужно идти по извилистой тропинке, чтобы достичь цели."
    //        note1.colorMark = .blue
    //        let  note2 = NoteModel()
    //        note2.text = "Жизнь — это не ожидание, когда буря пройдет, а учение танцевать под дождем."
    //        note2.colorMark = .red
    //        let  note3 = NoteModel()
    //        note3.text = "Лучший способ предсказать будущее — создать его самому."
    //        note3.colorMark = .red
    //        let  note4 = NoteModel()
    //        note4.text = "Иногда ты должен закрывать двери, чтобы открыть окна.\nИногда же нужно просто выбросить стены и дать свободу своим мечтам."
    //        let  note5 = NoteModel()
    //        note5.text = "Мир состоит из двух типов людей: тех, кто живет мечтой, и тех, кто следует за своими мечтами."
    //        let  note6 = NoteModel()
    //        note6.text = "Успех — это не окончательный результат.\nЭто непрерывный процесс, требующий постоянных усилий."
    //        let  note7 = NoteModel()
    //        note7.text = "Не позволяйте неудачам определять ваше будущее.\nВместо этого используйте их как возможность расти и учиться на своих ошибках."
    //        note7.colorMark = .orange
    //
    //        return [note1, note2, note3, note4, note5, note6, note7]
    //    }()
    
    
    
    
    
    private var listOfNotes: Results<NoteModel> = {
        var value = realm.objects(NoteModel.self)
        if value.isEmpty {
            let firstNote = NoteModel()
            StorageManager.saveNote(firstNote.createStartNote())
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
    
//    func deleteEmptyNote(completion: @escaping () -> ()) {
//        guard let first = listOfNotes.first else { return }
//        if first.text == "" {
//            listOfNotes.removeFirst()
//        }
//    }
}
