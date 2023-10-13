import Foundation
import FoundationHelpers
import Models

public extension MarvelCharacterComicsResponse {
  static var mock: MarvelCharacterComicsResponse {
    get throws {
      let fileUrl = Bundle.mocksModule.url(forResource: "characters-1009718-comics-response", withExtension: "json")!
      let data = try String(contentsOf: fileUrl).data(using: .utf8)
      return try data!.decode()
    }
  }
}
