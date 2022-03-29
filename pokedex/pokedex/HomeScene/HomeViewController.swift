//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Matheus Perez on 24/03/22.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    func setupNavBar() {
        let width = self.view.frame.width
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: self.view.safeAreaInsets.top, width: width, height: 44))
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        self.view.addSubview(navigationBar)
        let generationButton = UIBarButtonItem(image: UIImage(named: "generationIcon"), style: .plain, target: self, action: #selector(generationButtonTapped))
        generationButton.tintColor = Colors.black
        let sortButton = UIBarButtonItem(image: UIImage(named: "sortIcon"), style: .plain, target: self, action: #selector(sortButtonTapped))
        sortButton.tintColor = Colors.black
        let filterButton = UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .plain, target: self, action: #selector(filterButtonTapped))
        filterButton.tintColor = Colors.black
        navigationItem.rightBarButtonItems = [filterButton, sortButton, generationButton]
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleBold
        label.textColor = Colors.black
        label.text = "Pokédex"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.medium
        label.textColor = Colors.gray
        label.text = "Search for Pokémon by name or using the National Pokédex number."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var searchBar: UISearchTextField = {
        let searchBar = UISearchTextField()
        searchBar.backgroundColor = .clear
        searchBar.textColor = Colors.gray
        searchBar.tintColor = Colors.gray
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
        buildView()
    }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
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
        view.addSubview(summaryTitleStackView)
        view.addSubview(searchBar)
        view.addSubview(pokemonsTableView)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.backgroundColor
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
