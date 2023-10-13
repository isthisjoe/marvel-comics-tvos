import Foundation
import Models

public extension MarvelCharactersResponse {
  static var mock: MarvelCharactersResponse {
    get throws {
      let fileUrl = Bundle.mocksModule.url(forResource: "characters", withExtension: "json")!
      let data = try String(contentsOf: fileUrl).data(using: .utf8)
      return try JSONDecoder().decode(MarvelCharactersResponse.self, from: data!)
    }
  }
}
