//
//  HomePresenter.swift
//  pokedex
//
//  Created by Matheus Perez on 29/03/22.
//

protocol HomePresenting: AnyObject {
    func displayList()
    func displayEmptyState()
    func startLoading()
    func coordinateToSortFilter(sortFilterType: SortFilter, delegate: SortViewDelegate)
}

final class HomePresenter {
    private let router: HomeRoutering
    weak var viewController: HomeViewControllerDisplaying?
    
    init(router: HomeRoutering) {
        self.router = router
    }
}

extension HomePresenter: HomePresenting {
    func displayList() {
        viewController?.displayList()
    }
    
    func displayEmptyState() {
        viewController?.displayEmptyState()
    }
    
    func startLoading() {
        viewController?.startLoading()
    }
    
    func coordinateToSortFilter(sortFilterType: SortFilter, delegate: SortViewDelegate) {
        router.routerToSortFilter(sortFilterType: sortFilterType, delegate: delegate)
    }
}
