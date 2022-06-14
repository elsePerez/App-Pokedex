//
//  HomeInteractor.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//
import Alamofire

protocol HomeInteracting: AnyObject {
    func fetchData()
}

final class HomeInteractor {
    private let presenter: HomePresenting
    
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
            self.presenter.displayList(pokemons: pokemons)
        }
    }
}
