import Foundation

public struct MarvelCharacterComicsResponse: Codable {
  public struct Data: Codable {
    public let results: [Comic]
  }
  
  public let data: Data
}
