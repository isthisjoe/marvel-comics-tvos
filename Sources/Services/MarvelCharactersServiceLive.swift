import Combine
import Foundation
import FoundationHelpers
import Logs
import MarvelApiClient
import Models

public enum ServiceError: Error {
  case apiError(Error)
  case decodeError(Error)
  case unknownError
}

extension MarvelCharactersService {
  public static var live = MarvelCharactersService(
    fetchMarvelCharacters: { offset, limit in
      Future {
        try await MarvelApiClient.live.apiRequest(
          .characters(offset: offset, limit: limit)
        )
      }
      .mapError { error in
        Logger.services.error("API Error on \(#function):\(error)")
        return ServiceError.apiError(error)
      }
      .tryMap { data in
        do {
          let response: MarvelCharactersResponse = try data.decode()
          return response.data.results
        } catch {
          Logger.services.error("Decode Error on \(#function):\(error)")
          throw ServiceError.decodeError(error)
        }
      }
      .mapError { error in
        error as? ServiceError ?? .unknownError
      }
      .eraseToAnyPublisher()
    }
  )
}
