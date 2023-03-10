//
//  ColorMark.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import UIKit

enum ColorMark : String {
    case clear 
    case yellow
    case green
    case red
    case purple
    case orange
    case gray
    case blue
    
    func getColor() -> UIColor {
        switch self {
        case .clear:
            return .clear
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .red:
            return .red
        case .purple:
            return .purple
        case .orange:
            return .orange
        case .gray:
            return .gray
        case .blue:
            return .blue
        }
    }
}
