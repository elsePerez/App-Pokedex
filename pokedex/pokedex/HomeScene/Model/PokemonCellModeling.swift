//
//  PokemonCellModeling.swift
//  pokedex
//
//  Created by Cora on 14/06/22.
//

import Alamofire
import AlamofireImage
import UIKit
import SystemConfiguration

struct PokemonCellModeling {
    private let pokemon: PokemonModel
    private let pokemonImage: UIImage
    
    init(pokemon: PokemonModel, pokemonImage: UIImage) {
        self.pokemon = pokemon
        self.pokemonImage = pokemonImage
    }
    
    var id: String {
        "#\(pokemon.id)"
    }
    
    var name: String {
        pokemon.name
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
    
    var image: UIImage {
        pokemonImage
    }
    
    var backgroundColor: UIColor {
        getBackgroundCell(type: pokemon.types[0])
    }
}
