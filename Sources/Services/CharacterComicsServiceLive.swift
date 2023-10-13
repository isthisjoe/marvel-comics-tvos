import FoundationHelpers
import Logs
import MarvelApiClient
import Models

extension CharacterComicsService {
  public static var live = CharacterComicsService(
    fetchCharacterComics: { id, offset, limit in
      let data: Data
      do {
        data = try await MarvelApiClient.live.apiRequest(
          .characterComics(id: id, offset: offset, limit: limit)
        )
      } catch {
        Logger.services.error("API Error on \(#function):\(error)")
        throw ServiceError.apiError(error)
      }
      do {
        let response: MarvelCharacterComicsResponse = try data.decode()
        return response.data.results
      } catch {
        Logger.services.error("Decode Error on \(#function):\(error)")
        throw ServiceError.decodeError(error)
      }
    }
  )
}
