import Combine
import Models
import Mocks

extension MarvelCharactersService {
  public static var mock = MarvelCharactersService(
    fetchMarvelCharacters: { _, _ in
      Future {
        $0(.success(try! [MarvelCharacter].mock))
      }
      .eraseToAnyPublisher()
    }
  )
}
