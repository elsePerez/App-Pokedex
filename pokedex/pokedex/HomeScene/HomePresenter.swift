//
//  HomePresenter.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//

protocol HomePresenting: AnyObject {
    func teste()
}

final class HomePresenter {
    private let router: HomeRoutering
    weak var viewController: HomeViewControllerDisplaying?
    
    init(router: HomeRoutering) {
        self.router = router
    }
}

extension HomePresenter: HomePresenting {
    func teste() {
        
    }
}
