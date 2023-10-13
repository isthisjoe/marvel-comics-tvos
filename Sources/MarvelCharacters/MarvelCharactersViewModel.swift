import Combine
import CharacterComics
import Logs
import Models
import Services
import SwiftUI

public final class MarvelCharactersViewModel: ObservableObject {
  public enum Destination {
    case characterComics(CharacterComicsViewModel)
  }
  
  private var cancellables: Set<AnyCancellable> = []
  @Published public private(set) var destination: Destination?
  @Published public private(set) var marvelCharacters: LoadState<[MarvelCharacter]> = .none
  let marvelCharactersService: MarvelCharactersService
  public private(set) var pagination = Pagination()
  private let services: Services
  
  public init(services: Services) {
    self.marvelCharactersService = services.marvelCharactersService
    self.services = services
  }
  
  /// Loads the initial list of chracters.
  func loadMarvelCharacters() {
    self.pagination.reset()
    self.marvelCharacters = .loading
    self.fetchMarvelCharacters(pagination: self.pagination)
  }
  
  /// Creates or appends a list of character given a pagination.
  func fetchMarvelCharacters(pagination: Pagination) {
    self.marvelCharactersService.fetchMarvelCharacters(
      pagination.offset,
      pagination.limit
    )
      .receive(on: DispatchQueue.main)
      .map { results in
        self.pagination.hasMorePages = !results.isEmpty
        if self.pagination.offset == 0 {
          return .completed(results)
        } else {
          guard case var .completed(completedMarvelCharacters) = self.marvelCharacters else {
            return .completed(results)
          }
          results.forEach { completedMarvelCharacters.append($0) }
          return .completed(completedMarvelCharacters)
        }
      }
      .catch { error in
        Just(.error("There was a problem with fetching the characters"))
      }
      .assign(to: &self.$marvelCharacters)
  }
  
  /// Fetches the next page of characters when the first character of the current page appears
  func characterAppeared(_ character: MarvelCharacter) {
    guard case let .completed(result) = marvelCharacters,
          let row = result.firstIndex(of: character) else {
      return
    }
    if self.pagination.shouldIncrementOffset(row) {
      self.pagination.incrementOffset()
      fetchMarvelCharacters(pagination: self.pagination)
    }
  }
  
  /// Set the destination to `.characterComics` when a character is tapped.
  @MainActor 
  func characterTapped(_ character: MarvelCharacter) {
    self.destination = .characterComics(
      CharacterComicsViewModel(
        character: character,
        characterComicsService: services.characterComicsService
      )
    )
  }
  
  func resetDestination() {
    self.destination = nil
  }
}
