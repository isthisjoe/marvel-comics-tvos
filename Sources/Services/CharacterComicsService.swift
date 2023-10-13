import Models

/// This service contains a Character's Comics related data.
/// This service uses async/await to fetch data and report/display the appropriate errors
public struct CharacterComicsService {
  public private(set) var fetchCharacterComics: (
    _ id: Int,
    _ offset: Int,
    _ limit: Int
  ) async throws -> [Comic]
  
  public init(
    fetchCharacterComics: @escaping (
      _: Int,
      _: Int,
      _: Int
    ) async throws -> [Comic]
  ) {
    self.fetchCharacterComics = fetchCharacterComics
  }
}
