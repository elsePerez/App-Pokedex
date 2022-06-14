//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Matheus Perez on 24/03/22.
//

import UIKit
import SnapKit

protocol HomeViewControllerDisplaying: AnyObject {
    func displayTeste()
}

final class HomeViewController: UIViewController {
    private lazy var generationButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Images.generationIcon.image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(generationButtonTapped))
        button.tintColor = Colors.black.color
        return button
    }   ()
    
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Images.sortIcon.image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(sortButtonTapped))
        button.tintColor = Colors.black.color
        return button
    }()
    
    private lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Images.filterIcon.image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(filterButtonTapped))
        button.tintColor = Colors.black.color
        return button
    }()
    
    func setupNavBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.isTranslucent = true
        
        navigationItem.rightBarButtonItems = [filterButton, sortButton, generationButton]
    }
    
    private lazy var pokeballImage = UIImageView(image: Images.cutPokeballBackground.image)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleBold
        label.textColor = Colors.black.color
        label.text = "Pokédex"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.medium
        label.textColor = Colors.textGray.color
        label.text = "Search for Pokémon by name or using the National Pokédex number."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var searchBar: UISearchTextField = {
        let searchBar = UISearchTextField()
        searchBar.backgroundColor = .clear
        searchBar.textColor = Colors.textGray.color
        searchBar.tintColor = Colors.textGray.color
        searchBar.placeholder = "What Pokémon are you looking for?"
        return searchBar
    }()
    
    private lazy var pokemonsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonListCell.self, forCellReuseIdentifier: PokemonListCell.identifier)
        return tableView
    }()
    
    private lazy var summaryTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override func viewWillLayoutSubviews() {
        setupNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchData()
        buildView()
    }
    
    private let interactor: HomeInteracting
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
        pokeballImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        summaryTitleStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top + 100)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(summaryTitleStackView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
        }
        
        pokemonsTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
        }
    }
    
    func setupHierarchy() {
        view.addSubview(pokeballImage)
        view.addSubview(summaryTitleStackView)
        view.addSubview(searchBar)
        view.addSubview(pokemonsTableView)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.backgroundWhite.color
    }
}

// MARK: - Actions
private extension HomeViewController {
    @objc func filterButtonTapped() {
        view.backgroundColor = .red
    }
    
    @objc func generationButtonTapped() {
        view.backgroundColor = .blue
    }
    
    @objc func sortButtonTapped() {
        view.backgroundColor = .yellow
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICOU \(indexPath.row)")
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.identifier, for: indexPath)
        //        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - HomeViewControllerDisplaying
extension HomeViewController: HomeViewControllerDisplaying {
    func displayTeste() {
        
    }
}
