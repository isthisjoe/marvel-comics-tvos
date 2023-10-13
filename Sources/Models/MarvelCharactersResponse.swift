import Foundation

public struct MarvelCharactersResponse: Codable {
  public struct Data: Codable {
    public let results: [MarvelCharacter]
  }
  
  public let data: Data
}
