//
//  PokemonModel.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//

import Foundation

struct PokemonModel: Decodable, Equatable {
    let id: Int
    let name: String
    let image: URL
    let description: String
    let height: Float
    let weight: Float
    let species: String
    let types: [String]
    let training: Training
    let breedings: Breedings
    let baseStats: BaseStats
    let typeDefences: TypeDefences
}

struct Training: Decodable, Equatable {
    let evYield: String
    let catchRate: CatchRate
    let baseFriendship: BaseFriendship
    let baseExp: Int?
    let growthRate: String
}

struct CatchRate: Decodable, Equatable {
    let value: Int?
    let text: String
}

struct BaseFriendship: Decodable, Equatable {
    let value: Int?
    let text: String
}

struct Breedings: Decodable, Equatable {
    let eggGroups: [String]
    let gender: Gender
    let eggCycles: EggCycles
}

struct Gender: Decodable, Equatable {
    let male: Float?
    let female: Float?
}

struct EggCycles: Decodable, Equatable {
    let value: Int
    let text: String
}

struct BaseStats: Decodable, Equatable {
    let hp: [Int]
    let attack: [Int]
    let defence: [Int]
    let specialAttack: [Int]
    let specialDefence: [Int]
    let speed: [Int]
}

struct TypeDefences: Decodable, Equatable {
    let normal: Float?
    let fire: Float?
    let water: Float?
    let electric: Float?
    let grass: Float?
    let ice: Float?
    let fighting: Float?
    let poison: Float?
    let ground: Float?
    let flying: Float?
    let psychic: Float?
    let bug: Float?
    let rock: Float?
    let ghost: Float?
    let dragon: Float?
    let darl: Float?
    let steel: Float?
    let fairy: Float?
}
