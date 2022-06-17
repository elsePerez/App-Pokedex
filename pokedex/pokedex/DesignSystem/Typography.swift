//
//  Typography.swift
//  Pokedex
//
//  Created by Matheus Perez on 25/03/22.
//

import UIKit

fileprivate enum FontName {
    static let bold = "SF Pro Display Bold"
    static let regular = "SF Pro Display Regular"
}

enum Typography {
    /// Bold 32
    static let primaryTitle = UIFont(name: FontName.bold, size: 32)
    
    /// Bold 26
    static let secondaryTitle = UIFont(name: FontName.bold, size: 26)
    
    /// Bold 16
    static let tertiaryTitle = UIFont(name: FontName.bold, size: 16)
    
    /// Regular 16
    static let primarySubtitle = UIFont(name: FontName.regular, size: 16)
    
    /// Regular 12
    static let secondarySubtitle = UIFont(name: FontName.regular, size: 12)
}
