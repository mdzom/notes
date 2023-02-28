//
//  ListOfNotesViewController+Extension.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import UIKit

extension ListOfNotesViewController: UITableViewDelegate {}

extension ListOfNotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier,
                                                       for: indexPath) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.createCellViewModel(for: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectedBackgroundView = SelectedCellView()
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel?.selectRow(at: indexPath)
        guard let controller = viewModel?.viewModelForSelectedRow() else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: nil) { [weak self] (_, _, completion) in
            self?.viewModel?.selectRow(at: indexPath)
            self?.viewModel?.deleteNote(completion: {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .orange
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

