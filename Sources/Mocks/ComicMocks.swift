import Models

public extension Comic {
  static var mock: Comic {
    get throws {
      let response = try MarvelCharacterComicsResponse.mock
      return response.data.results[0]
    }
  }
}

public extension Array where Element == Comic {
  static var mock: Array<Comic> {
    get throws {
      let response = try MarvelCharacterComicsResponse.mock
      return response.data.results
    }
  }
}
