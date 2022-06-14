//
//  PokemonBadgeType.swift
//  pokedex
//
//  Created by Cora on 14/06/22.
//

import Foundation
import UIKit

func getImageBadge(type: PokemonType) -> UIImage {
    switch type {
    case .bug:
        return Images.bug.image
    case .dark:
        return Images.dark.image
    case .dragon:
        return Images.dragon.image
    case .electric:
        return Images.eletric.image
    case .fairy:
        return Images.fairy.image
    case .fighting:
        return Images.fighting.image
    case .fire:
        return Images.fire.image
    case .flying:
        return Images.flying.image
    case .ghost:
        return Images.ghost.image
    case .grass:
        return Images.grass.image
    case .ground:
        return Images.ground.image
    case .ice:
        return Images.ice.image
    case .normal:
        return Images.normal.image
    case .poison:
        return Images.poison.image
    case .psychic:
        return Images.psychic.image
    case .rock:
        return Images.rock.image
    case .steel:
        return Images.steel.image
    case .water:
        return Images.water.image
    }
}

func getBackgroundCell(type: PokemonType) -> UIColor {
    switch type {
    case .bug:
        return Colors.bug.color
    case .dark:
        return Colors.dark.color
    case .dragon:
        return Colors.dragon.color
    case .electric:
        return Colors.electric.color
    case .fairy:
        return Colors.fairy.color
    case .fighting:
        return Colors.fighting.color
    case .fire:
        return Colors.fire.color
    case .flying:
        return Colors.flying.color
    case .ghost:
        return Colors.ghost.color
    case .grass:
        return Colors.grass.color
    case .ground:
        return Colors.ground.color
    case .ice:
        return Colors.ice.color
    case .normal:
        return Colors.normal.color
    case .poison:
        return Colors.poison.color
    case .psychic:
        return Colors.psychic.color
    case .rock:
        return Colors.rock.color
    case .steel:
        return Colors.steel.color
    case .water:
        return Colors.water.color
    }
}
