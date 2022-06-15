//
//  PokemonCellModeling.swift
//  pokedex
//
//  Created by Cora on 14/06/22.
//

import Alamofire
import UIKit

struct PokemonCellModeling {
    private let pokemon: PokemonModel
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    
    var url: URL {
        pokemon.image
    }
    
    var id: String {
        "#\(pokemon.id)"
    }
    
    var name: String {
        pokemon.name.firstUppercased
    }
    
    var primaryType: UIImage {
        getImageBadge(type: pokemon.types[0])
    }
    
    var secondaryType: UIImage? {
        if pokemon.types.count > 1 {
            return getImageBadge(type: pokemon.types[1])
        }
        return nil
    }
    
    var backgroundColor: UIColor {
        getBackgroundCell(type: pokemon.types[0])
    }
}
