//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    weak var viewModel: NoteCellViewModelProtocol? {
        willSet(viewModel) {
            colorMarkView.backgroundColor = viewModel?.colorMark.getColor()
            titleLabel.text = viewModel?.title
            mainTextLabel.text = viewModel?.text
        }
    }
    
    private lazy var borderView: UIView = {
        let borderColor = Constant.Colors.gray.cgColor
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = borderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var colorMarkView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        
//view.backgroundColor = .red
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
//label.text = "Object"
        
        label.textColor = Constant.Colors.black
        return label
    }()
    
    private lazy var mainTextLabel: UILabel = {
        let label = UILabel()
        
//label.text = "text"
        
        label.textColor = Constant.Colors.gray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(mainTextLabel)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addToView()
        addConstraint()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addToView() {
        addSubview(borderView)
        addSubview(colorMarkView)
        addSubview(stackView)
    }
    
    private func addConstraint() {
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        borderView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        borderView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        colorMarkView.translatesAutoresizingMaskIntoConstraints = false
        colorMarkView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 8).isActive = true
        colorMarkView.leftAnchor.constraint(equalTo: borderView.leftAnchor, constant: 8).isActive = true
        colorMarkView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -8).isActive = true
        colorMarkView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 8).isActive = true
        stackView.leftAnchor.constraint(equalTo: colorMarkView.rightAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: borderView.rightAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -8).isActive = true
    }
}
