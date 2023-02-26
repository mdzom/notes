//
//  SelectedCellView.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import UIKit

class SelectedCellView: UIView {
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constant.Colors.gray
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addToView()
        addConstraint()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addToView() {
        addSubview(colorView)
    }
    
    private func addConstraint() {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        colorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        colorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
}
