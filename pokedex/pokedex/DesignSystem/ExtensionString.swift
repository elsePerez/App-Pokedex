//
//  ExtensionString.swift
//  pokedex
//
//  Created by Cora on 14/06/22.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
