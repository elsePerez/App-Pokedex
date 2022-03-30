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
        let url = URLRequest(url: URL(string: "https://pokemon-db-json.herokuapp.com/")!)
        AF.request(url).validate().response { response in
            
        }
    }
}
