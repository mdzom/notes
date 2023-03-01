//
//  UIResponder+Extension.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 28.02.2023.
//

import UIKit

extension UIResponder {
    func createColorPickerButton(color: UIColor) -> UIButton {
        let borderColor = Constant.Colors.black.cgColor
        let button = UIButton.init(type: .system)
        button.backgroundColor = color
        button.layer.borderColor = borderColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8
        return button
    }
}
