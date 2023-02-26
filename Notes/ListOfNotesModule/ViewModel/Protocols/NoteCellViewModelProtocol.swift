//
//  NoteCellViewModelProtocol.swift
//  Notes
//
//  Created by Gennadij Pleshanov on 26.02.2023.
//

import Foundation

protocol NoteCellViewModelProtocol: AnyObject {
    var title: String { get }
    var text: String { get }
    var colorMark: ColorMark { get }
}
