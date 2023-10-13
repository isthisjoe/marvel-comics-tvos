import SwiftUI

public struct Fonts {
  static let bodyFontSize: CGFloat = 16
  static let largeTitleFontSize: CGFloat = 40
  static let titleFontSize: CGFloat = 24
  
  public static var bodyFont: Font {
    Font.system(size: Self.bodyFontSize, weight: .regular)
  }
  
  public static var largeTitleFont: Font {
    Font.system(size: Self.largeTitleFontSize, weight: .bold)
  }
  
  public static var titleFont: Font {
    Font.system(size: Self.titleFontSize, weight: .bold)
  }
}
