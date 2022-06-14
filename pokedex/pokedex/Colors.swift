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
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Colors {
  internal static let backgroundDefaultInput = ColorAsset(name: "backgroundDefaultInput")
  internal static let backgroundModal = ColorAsset(name: "backgroundModal")
  internal static let backgroundPressedInput = ColorAsset(name: "backgroundPressedInput")
  internal static let bug = ColorAsset(name: "bug")
  internal static let dark = ColorAsset(name: "dark")
  internal static let dragon = ColorAsset(name: "dragon")
  internal static let electric = ColorAsset(name: "electric")
  internal static let fairy = ColorAsset(name: "fairy")
  internal static let fighting = ColorAsset(name: "fighting")
  internal static let fire = ColorAsset(name: "fire")
  internal static let flying = ColorAsset(name: "flying")
  internal static let ghost = ColorAsset(name: "ghost")
  internal static let grass = ColorAsset(name: "grass")
  internal static let ground = ColorAsset(name: "ground")
  internal static let ice = ColorAsset(name: "ice")
  internal static let normal = ColorAsset(name: "normal")
  internal static let poison = ColorAsset(name: "poison")
  internal static let psychic = ColorAsset(name: "psychic")
  internal static let rock = ColorAsset(name: "rock")
  internal static let steel = ColorAsset(name: "steel")
  internal static let water = ColorAsset(name: "water")
  internal static let backgroundWhite = ColorAsset(name: "backgroundWhite")
  internal static let black = ColorAsset(name: "black")
  internal static let textGray = ColorAsset(name: "textGray")
  internal static let textNumber = ColorAsset(name: "textNumber")
  internal static let white = ColorAsset(name: "white")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
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
