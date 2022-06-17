//
//  PokemonListCell.swift
//  pokedex
//
//  Created by Matheus Perez on 25/03/22.
//

import Alamofire
import Kingfisher
import UIKit

extension PokemonListCell.Layout {
    enum Size {
        static let image = CGSize(width: 74, height: 32)
        static let status: CGFloat = 12
    }
}

final class PokemonListCell: UITableViewCell {
    fileprivate enum Layout { }
    
    static let identifier: String = "PokemonListCell"
    
    private lazy var imageBackGroundCell: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.image = Images.cellBackground.image
        image.tintColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.30)
        return image
    }()
    
//    lazy var gradientLayer: CAGradientLayer = {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
//        gradientLayer.colors = [UIColor.white.cgColor,UIColor.red.withAlphaComponent(0.5).cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        layer.addSublayer(gradientLayer)
//        return gradientLayer
//    }()
    
    //    let gradient = CAGradientLayer()
    //    gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
    //    gradientLayer.locations = [0.0 , 1.0]
    //    gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
    //    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    //    return gradient
    
    private lazy var pokeballBackGroundCell: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.image = Images.pokeballBackground.image
        image.tintColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.30)
        return image
    }()
    
    private lazy var pokemonImage: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var pokemonId: UILabel = {
        let label = UILabel()
        label.font = Typography.secondarySubtitle
        label.textColor = Colors.textNumber.color
        return label
    }()
    
    private lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = Typography.secondaryTitle
        label.textColor = Colors.white.color
        return label
    }()
    
    private lazy var badgeOne: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var badgeTwo: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
//    private lazy var dataStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [pokemonId, pokemonName])
//        stackView.axis = .vertical
//        return stackView
//    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    func setup(pokemon: PokemonCellModeling) {
        pokemonId.text = pokemon.id
        pokemonName.text = pokemon.name
        badgeOne.image = pokemon.primaryType
        badgeTwo.image = pokemon.secondaryType
        rootStackView.backgroundColor = pokemon.backgroundColor
        pokemonImage.kf.setImage(with: pokemon.url)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImage.image = nil
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
}
// MARK: - Setup Views
extension PokemonListCell: ViewSetup {
    func setupConstraints() {
        imageBackGroundCell.frame = CGRect(x: 90, y: 35, width: 74, height: 32)
        
        pokeballBackGroundCell.frame = CGRect(x: contentView.frame.width - 120, y: 15, width: 145, height: 145)
        
        pokemonImage.frame = CGRect(x: contentView.frame.width - 130, y: 0, width: 130, height: 130)
        
        pokemonId.frame = CGRect(x: 30, y: 45, width: 50, height: 14)
    
        pokemonName.frame = CGRect(x: 30, y: 60, width: 170, height: 32)
        
        badgeOne.frame = CGRect(x: 30, y: 98, width: 65, height: 25)

        badgeTwo.frame = CGRect(x: 100, y: 98, width: 65, height: 25)
        
        rootStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupHierarchy() {
        contentView.addSubview(rootStackView)
        contentView.addSubview(imageBackGroundCell)
        contentView.addSubview(pokeballBackGroundCell)
        contentView.addSubview(pokemonImage)
        contentView.addSubview(pokemonId)
        contentView.addSubview(pokemonName)
        contentView.addSubview(badgeOne)
        contentView.addSubview(badgeTwo)
    }
    
    func setupStyles() {
        backgroundColor = .white
    }
}
