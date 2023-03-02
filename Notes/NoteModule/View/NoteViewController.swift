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
            colorSelectionButton.backgroundColor = viewModel?.color.getColor()
        }
    }
    
    private lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Готово",
                                     style: .plain,
                                     target: self,
                                     action: #selector(hideKeyboard))
        button.isEnabled = false
        button.tintColor = .clear
        return button
    }()
    
    private lazy var leftBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                     style: .done,
                                     target: self,
                                     action: #selector(pushBackButton))
        button.tintColor = Constant.Colors.gray
        return button
    }()
    
    private lazy var colorSelectionButton: UIButton = {
        let button = createColorPickerButton(color: .clear)
        button.addTarget(self,
                         action: #selector(pressButtonSelectColor),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "ArialMT", size: 18)
        textView.textColor = Constant.Colors.black
        textView.delegate = self
        return textView
    }()
    
    private lazy var viewWithChoiceOfLabelColor: UIView = {
        let view = ViewWithChoiceOfLabelColor()
        view.buttonAction = { [weak self] mark in
            self?.selectColor(mark)
        }
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.Colors.lighGgray
        addToNavigationItem()
        addToView()
        addConstraint()
        saveNote()
        addKeyboardObserver()
        showKeyboard()
    }
    
    private func addToNavigationItem() {
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
        
        let barButton = UIBarButtonItem(customView: colorSelectionButton)
        navigationItem.titleView = barButton.customView
    }
    
    private func addToView() {
        view.addSubview(textView)
        view.addSubview(viewWithChoiceOfLabelColor)
    }
    
    private func  addConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        textView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        viewWithChoiceOfLabelColor.translatesAutoresizingMaskIntoConstraints = false
        viewWithChoiceOfLabelColor.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewWithChoiceOfLabelColor.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
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
    
    private func addKeyboardObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self,
                                 selector: #selector(updateTextView(notification:)),
                                 name: UIResponder.keyboardWillChangeFrameNotification,
                                 object: nil)
        notification.addObserver(self,
                                 selector: #selector(updateTextView(notification:)),
                                 name: UIResponder.keyboardWillHideNotification,
                                 object: nil)
    }
    
    private func showKeyboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.textView.becomeFirstResponder()
            self?.rightBarButton.isEnabled = true
        }
    }
    
    @IBAction private func updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
            
            rightBarButton.isEnabled = false
            rightBarButton.tintColor = .clear
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                 bottom: keyboardFrame.height,
                                                 right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
            
            rightBarButton.isEnabled = true
            rightBarButton.tintColor = Constant.Colors.gray
        }
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    private func selectColor(_ mark: ColorMark) {
        colorSelectionButton.backgroundColor = mark.getColor()
        
        viewModel?.saveColorMark(mark)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.viewWithChoiceOfLabelColor.alpha = 0
        }
    }
    
    @IBAction private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction private func pushBackButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func pressButtonSelectColor() {
        viewWithChoiceOfLabelColor.isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.viewWithChoiceOfLabelColor.alpha = 1
        }
    }
}
