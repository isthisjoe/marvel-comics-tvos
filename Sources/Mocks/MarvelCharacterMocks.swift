import Models

public extension MarvelCharacter {
  static var mock: MarvelCharacter {
    get throws {
      let response = try MarvelCharactersResponse.mock
      return response.data.results[0]
    }
  }
}

public extension Array where Element == MarvelCharacter {
  static var mock: Array<MarvelCharacter> {
    get throws {
      let response = try MarvelCharactersResponse.mock
      return response.data.results
    }
  }
}
