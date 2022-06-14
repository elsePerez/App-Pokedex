//
//  HomeInteractor.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//
import Alamofire

protocol HomeInteracting: AnyObject {
    func fetchData()
    func getContentCell(index: IndexPath) -> PokemonCellModeling
}

final class HomeInteractor {
    private let presenter: HomePresenting
    private var pokemons = [PokemonModel]()
    private var pokemonImage = [UIImage]()
    
    init(presenter: HomePresenting) {
        self.presenter = presenter
    }
}

// MARK: - HomeInteracting
extension HomeInteractor: HomeInteracting {
    func fetchData() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let url = URLRequest(url: URL(string: "https://pokemon-db-json.herokuapp.com/")!)
        AF.request(url).responseDecodable(of: [PokemonModel].self, decoder: decoder) { (response) in
            guard let pokemons = response.value else {
                print(response.error ?? "Unknown error")
                return }
            self.pokemons = pokemons
            self.presenter.displayList()
        }
    }
    
    func getImage(index: IndexPath) {
        AF.request(pokemons[index.row].image).responseImage { (response) in
            guard let data = response.data else { return }
            self.pokemonImage.append(UIImage(data: data, scale: 1.0) ?? Images.bug.image)
        }
    }
    
    func getContentCell(index: IndexPath) -> PokemonCellModeling {
        guard pokemons.indices.contains(index.row) else {
            return PokemonCellModeling(pokemon: PokemonModel(id: 0,
                                                             name: "",
                                                             image: URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png")!,
                                                             description: "",
                                                             height: 0.0,
                                                             weight: 0.0,
                                                             species: "",
                                                             types: [.bug],
                                                             training: Training(evYield: "",
                                                                                catchRate: CatchRate(value: nil,
                                                                                                     text: ""),
                                                                                baseFriendship: BaseFriendship(value: nil,
                                                                                                               text: ""),
                                                                                baseExp: nil,
                                                                                growthRate: ""),
                                                             breedings: Breedings(eggGroups: [""],
                                                                                  gender: Gender(male: nil,
                                                                                                 female: nil),
                                                                                  eggCycles: EggCycles(value: 0,
                                                                                                       text: "")),
                                                             baseStats: BaseStats(hp: [0],
                                                                                  attack: [0],
                                                                                  defence: [0],
                                                                                  specialAttack: [0],
                                                                                  specialDefence: [0],
                                                                                  speed: [0]),
                                                             typeDefences: TypeDefences(normal: nil, fire: nil, water: nil, electric: nil, grass: nil, ice: nil, fighting: nil, poison: nil, ground: nil, flying: nil, psychic: nil, bug: nil, rock: nil, ghost: nil, dragon: nil, darl: nil, steel: nil, fairy: nil)),
                                       pokemonImage: Images.generationIcon.image)
        }
        self.getImage(index: index)
        return PokemonCellModeling(pokemon: pokemons[index.row], pokemonImage: pokemonImage)
    }
}
