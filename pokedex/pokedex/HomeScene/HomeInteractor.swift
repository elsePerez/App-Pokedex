//
//  HomeInteractor.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//
import Alamofire

protocol HomeInteracting: AnyObject {
    func fetchData()
    func getNumberOfRows() -> Int
    func getContentCell(index: IndexPath) -> PokemonCellModeling?
}

final class HomeInteractor {
    private let presenter: HomePresenting
    private var pokemons = [PokemonModel]()
    
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
    
    func getNumberOfRows() -> Int {
        pokemons.count
    }
    
    func getContentCell(index: IndexPath) -> PokemonCellModeling? {
        guard pokemons.indices.contains(index.row) else {
            return nil
        }
        return PokemonCellModeling(pokemon: pokemons[index.row])
    }
}
