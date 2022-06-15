// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Images {
  internal static let cellBackground = ImageAsset(name: "cellBackground")
  internal static let cutPokeballBackground = ImageAsset(name: "cutPokeballBackground")
  internal static let pokeballBackground = ImageAsset(name: "pokeballBackground")
  internal static let bug = ImageAsset(name: "bug")
  internal static let dark = ImageAsset(name: "dark")
  internal static let dragon = ImageAsset(name: "dragon")
  internal static let eletric = ImageAsset(name: "eletric")
  internal static let fairy = ImageAsset(name: "fairy")
  internal static let fighting = ImageAsset(name: "fighting")
  internal static let fire = ImageAsset(name: "fire")
  internal static let flying = ImageAsset(name: "flying")
  internal static let ghost = ImageAsset(name: "ghost")
  internal static let grass = ImageAsset(name: "grass")
  internal static let ground = ImageAsset(name: "ground")
  internal static let ice = ImageAsset(name: "ice")
  internal static let normal = ImageAsset(name: "normal")
  internal static let poison = ImageAsset(name: "poison")
  internal static let psychic = ImageAsset(name: "psychic")
  internal static let rock = ImageAsset(name: "rock")
  internal static let steel = ImageAsset(name: "steel")
  internal static let water = ImageAsset(name: "water")
  internal static let filterIcon = ImageAsset(name: "filterIcon")
  internal static let generationIcon = ImageAsset(name: "generationIcon")
  internal static let sortIcon = ImageAsset(name: "sortIcon")
  internal static let searchEmpty = ImageAsset(name: "searchEmpty")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
