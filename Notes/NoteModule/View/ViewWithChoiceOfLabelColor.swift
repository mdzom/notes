//
//  ViewWithChoiceOfLabelColor.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 28.02.2023.
//

import UIKit

class ViewWithChoiceOfLabelColor: UIView {
    
    var buttonAction: ((ColorMark) -> ())?
    
    private lazy var stackView: UIStackView = {
        let buttons = createAnArrayOfColorPickerButtons()
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.layer.cornerRadius = 8
        stackView.backgroundColor = Constant.Colors.lighGgray
        buttons.forEach { stackView.addArrangedSubview($0) }
        return stackView
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
        addSubview(stackView)
    }
    
    private func addConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func createAnArrayOfColorPickerButtons() -> [UIButton] {
        let colors: [ColorMark] = [.clear, .yellow,
                                   .green, .red,
                                   .purple, .orange,
                                   .gray, .blue]
        var array = [UIButton]()
        
        for (index, value) in colors.enumerated() {
            let button = createColorPickerButton(color: value.getColor())
            button.addTarget(self,
                             action: #selector(pressButtonSelectColor),
                             for: .touchUpInside)
            button.tag = index
            array.append(button)
        }
        return array
    }
    
    @IBAction private func pressButtonSelectColor(_ sender: UIButton) {
        var color = ColorMark.clear
        
        switch sender.tag {
        case 1:
            color = .yellow
        case 2:
            color = .green
        case 3:
            color = .red
        case 4:
            color = .purple
        case 5:
            color = .orange
        case 6:
            color = .gray
        case 7:
            color = .blue
            
        default:
            color = .clear
        }
        buttonAction?(color)
    }
}
