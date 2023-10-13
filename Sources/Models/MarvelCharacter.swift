import Foundation

public struct MarvelCharacter: Codable, Equatable, Identifiable {
  private struct Thumbnail: Codable, Equatable {
    let path: String
    let `extension`: String
  }
  
  public let id: Int
  public let name: String
  private let thumbnail: Thumbnail
}

extension MarvelCharacter {
  public var thumbnailUrl: URL? {
    URL(string: "\(self.thumbnail.path).\(self.thumbnail.extension)")
  }
}
