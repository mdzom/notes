//
//  NoteViewController.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import UIKit
import Combine

class NoteViewController: UIViewController {
    
    private var subscription: AnyCancellable?
    
    var viewModel: NoteViewModelProtocol? {
        willSet(viewModel) {
            textView.text = viewModel?.text
        }
    }
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        
        view.font = UIFont(name: "Copperplate-Light", size: 20)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.Colors.lighGgray
        addToView()
        addConstraint()
        saveNote()
    }
    
    private func addToView() {
        view.addSubview(textView)
    }
    
    private func  addConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        textView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    private func saveNote() {
        subscription = NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: textView)
            .compactMap { $0.object as? UITextView }
            .compactMap { $0.text }
            .sink { [weak self] in
                self?.viewModel?.saveNote(text: $0)
            }
    }
}
