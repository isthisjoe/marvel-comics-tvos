import Combine
import Models

/// This service contains Marvel Characters related data.
/// This service uses Combine to fetch data and report/display the appropriate errors
public struct MarvelCharactersService {
  public private(set) var fetchMarvelCharacters: (_ offset: Int, _ limit: Int) -> AnyPublisher<[MarvelCharacter], ServiceError>
  
  public init(fetchMarvelCharacters: @escaping (_: Int, _: Int) -> AnyPublisher<[MarvelCharacter], ServiceError>) {
    self.fetchMarvelCharacters = fetchMarvelCharacters
  }
}
