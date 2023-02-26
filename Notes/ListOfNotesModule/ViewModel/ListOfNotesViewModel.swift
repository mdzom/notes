//
//  ListOfNoteViewModel.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation

class ListOfNoteViewModel: ListOfNotesViewModelProtocol {
    
    var cellIdentifier = "kjgh3s456fjfhDfhgEH"
    
    private var selectedIndexPath: IndexPath?
    
    //    private var listOfNotes = [NoteModel]()
    private var listOfNotes = [
        NoteModel(text: "Важно помнить, что путь к успеху не всегда прямой.\nИногда нам нужно идти по извилистой тропинке, чтобы достичь цели.", colorMark: .blue),
        NoteModel(text: "Жизнь — это не ожидание, когда буря пройдет, а учение танцевать под дождем.", colorMark: .red),
        NoteModel(text: "Лучший способ предсказать будущее — создать его самому.", colorMark: .red),
        NoteModel(text: "Иногда ты должен закрывать двери, чтобы открыть окна.\nИногда же нужно просто выбросить стены и дать свободу своим мечтам.", colorMark: .clear),
        NoteModel(text: "Мир состоит из двух типов людей: тех, кто живет мечтой, и тех, кто следует за своими мечтами.", colorMark: .clear),
        NoteModel(text: "Успех — это не окончательный результат.\nЭто непрерывный процесс, требующий постоянных усилий.", colorMark: .clear),
        NoteModel(text: "Не позволяйте неудачам определять ваше будущее.\nВместо этого используйте их как возможность расти и учиться на своих ошибках.", colorMark: .orange)
    ]
    
    
    
    
    //    private var listOfNotes: Results<NoteModel> {
    //        realm.objects(NoteModel.self)
    //    }
    
    
    //    private var expenseCategory: Results<ExpenseCategory> {
    //        realm.objects(ExpenseCategory.self)
    //    }
    
    
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
        let viewController = NoteViewController()
        //        viewController.viewModel = NoteViewModel(note: note)
        //        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    
    func selectRow(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    //    func addNote(text: String, completion: @escaping () -> ()) {
    ////        let emptyList = List<Expense>()
    ////        let newCategory = ExpenseCategory(category: category,
    ////                                          expence: emptyList)
    ////        try! realm.write({
    ////            realm.add(newCategory)
    ////        })
    ////        completion()
    //    }
    
    
}
