//
//  ListOfNotesViewController.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import UIKit

class ListOfNotesViewController: UIViewController {
    
    var viewModel: ListOfNotesViewModelProtocol?
    
    private lazy var tableView: UITableView = {
        guard let viewModel else { return UITableView() }
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteTableViewCell.self,
                           forCellReuseIdentifier: viewModel.cellIdentifier)
        return tableView
    }()
    
    private lazy var addNoteButton: UIButton = {
        let borderColor = Constant.Colors.gray.cgColor
        let button = UIButton.init(type: .system)
        button.tintColor = Constant.Colors.black
        button.addTarget(self,
                         action: #selector(addNote),
                         for: .touchUpInside)
        button.setTitle("Add note..",
                        for: .normal)
        button.layer.borderColor = borderColor
        button.layer.borderWidth = 1
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        viewModel?.lastNoteCheck { [weak self] indexPath in
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.Colors.lighGgray
        viewModel = ListOfNoteViewModel()
        addToView()
        addConstraint()
    }
    
    private func addToView() {
        view.addSubview(tableView)
        view.addSubview(addNoteButton)
    }
    
    private func addConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: addNoteButton.topAnchor).isActive = true
        
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        addNoteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addNoteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -1).isActive = true
        addNoteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 1).isActive = true
        addNoteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    @IBAction private func addNote() {
        viewModel?.addNote(completion: { [weak self] controller in
            self?.tableView.reloadData()
            self?.navigationController?.pushViewController(controller, animated: true)
        })
    }
}
