//
//  Constant.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import UIKit

enum Constant {
    
    enum Colors {
        static var black: UIColor {
            if let color = UIColor(named: "Black") {
                return color
            }
            return UIColor()
        }
        
        static var gray: UIColor {
            if let color = UIColor(named: "Gray") {
                return color
            }
            return UIColor()
        }
        
        static var lighGgray: UIColor {
            if let color = UIColor(named: "LightGray") {
                return color
            }
            return UIColor()
        }
    }
}
