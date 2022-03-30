//
//  HomeFactory.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//

import UIKit

enum HomeFactory {
    static func make() -> HomeViewController {
        let router = HomeRouter()
        let presenter = HomePresenter(router: router)
        let interactor = HomeInteractor(presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
