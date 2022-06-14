//
//  HomeInteractor.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//
import Alamofire
import AlamofireImage

protocol HomeInteracting: AnyObject {
    func fetchData()
    func getContentCell(index: IndexPath) -> PokemonCellModeling
}

final class HomeInteractor {
    private let presenter: HomePresenting
    private var pokemons = [PokemonModel]()
    private var pokemonImage = UIImage()
    private let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111,
                                                   preferredMemoryUsageAfterPurge: 90_000_000)
    
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
    
    func loadImage(index: IndexPath) {
        AF.request(pokemons[index.row].image).responseImage { [self] (response) in
            guard let data = response.data else { return }
//            self.pokemonImage = UIImage(data: data, scale: 1.0) ?? Images.bug.image
            let image = UIImage(data: data, scale: 1.0) ?? Images.bug.image
            imageCache.add(image, withIdentifier: pokemons[index.row].image.absoluteString)
        }
    }
    
    func getImage(index: IndexPath) -> UIImage {
        guard let image = imageCache.image(withIdentifier: self.pokemons[index.row].image.absoluteString) else {
            return UIImage()
        }
        return image
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
                                       pokemonImage: UIImage())
        }
        self.loadImage(index: index)
        return PokemonCellModeling(pokemon: pokemons[index.row],
                                   pokemonImage: self.getImage(index: index))
    }
}
