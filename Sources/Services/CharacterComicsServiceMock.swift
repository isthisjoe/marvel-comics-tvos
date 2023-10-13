import Models
import Mocks

extension CharacterComicsService {
  public static var mock = CharacterComicsService(
    fetchCharacterComics: { _, _, _ in
      try await Task.sleep(nanoseconds: 1)
      return try [Comic].mock
    }
  )
}
