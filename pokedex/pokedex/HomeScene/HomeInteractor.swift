//
//  HomeInteractor.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//
import Alamofire
import SwiftGoogleTranslate
import Foundation

protocol HomeInteracting: AnyObject {
    func fetchData()
    func getNumberOfRows() -> Int
    func getContentCell(index: IndexPath) -> PokemonCellModeling?
    func searchPokemons(pokemonName: String)
    func getSortFilter(sortFilterType: SortFilter)
    func showFilter(delegate: SortViewDelegate)
}

final class HomeInteractor {
    private let presenter: HomePresenting
    private var pokemonsList = [PokemonModel]()
    private var pokemonsFilter = [PokemonModel]()
    private var sortFilterType: SortFilter?
    
    init(presenter: HomePresenting) {
        self.presenter = presenter
    }
}

private extension HomeInteractor {
    func sortFilterSmallest() {
        guard pokemonsFilter[0].id == 1 else {
            presenter.startLoading()
            pokemonsFilter.reverse()
            Timer.scheduledTimer(timeInterval: 0.5,
                                 target: self,
                                 selector: #selector(timerAction),
                                 userInfo: nil,
                                 repeats: false)
            return
        }
    }
    
    func sortFilterHighest() {
        guard pokemonsFilter[0].id == 1 else { return }
        presenter.startLoading()
        pokemonsFilter.reverse()
        Timer.scheduledTimer(timeInterval: 0.5,
                             target: self,
                             selector: #selector(timerAction),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func timerAction(){
        presenter.displayList()
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
            self.pokemonsList = pokemons
            self.pokemonsFilter = pokemons
            self.presenter.displayList()
        }
    }
    
    func getNumberOfRows() -> Int {
        pokemonsFilter.count
    }
    
    func getContentCell(index: IndexPath) -> PokemonCellModeling? {
        guard pokemonsFilter.indices.contains(index.row) else {
            return nil
        }
        return PokemonCellModeling(pokemon: pokemonsFilter[index.row])
    }
    
    func searchPokemons(pokemonName: String) {
        guard !pokemonName.isEmpty else {
            pokemonsFilter = pokemonsList
            presenter.displayList()
            return
        }
        let filteredList = pokemonsList.filter { pokemon in
            pokemon.name.contains(pokemonName)
        }
        pokemonsFilter.removeAll()
        pokemonsFilter = filteredList
        if pokemonsFilter.isEmpty {
            presenter.displayEmptyState()
        } else {
            presenter.displayList()
        }
    }
    
    func getSortFilter(sortFilterType: SortFilter) {
        self.sortFilterType = sortFilterType
        switch sortFilterType {
        case .sortSmallest:
            sortFilterSmallest()
        case .sortHighest:
            sortFilterHighest()
        case .sortAZ:
            print("B")
        case .sortZA:
            print("C")
        }
    }
    
    func showFilter(delegate: SortViewDelegate) {
        presenter.coordinateToSortFilter(sortFilterType: self.sortFilterType ?? .sortSmallest,
                                         delegate: delegate)
    }
}
