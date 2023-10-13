import Logs
import Models
import Services
import SwiftUI

@MainActor
public final class CharacterComicsViewModel: ObservableObject {
  @Published public private(set) var comics: LoadState<[Comic]> = .none
  @Published public private(set) var character: MarvelCharacter
  private let characterComicsService: CharacterComicsService
  public private(set) var pagination = Pagination()
  
  var characterThumbnailUrl: URL? {
    self.character.thumbnailUrl
  }
  
  var characterName: String {
    self.character.name
  }
  
  public init(
    character: MarvelCharacter,
    characterComicsService: CharacterComicsService
  ) {
    self.character = character
    self.characterComicsService = characterComicsService
  }
  
  /// Loads the initial list of comics.
  func loadComics() async {
    self.pagination.reset()
    self.comics = .loading
    await fetchCharacterComics(
      id: self.character.id,
      pagination: self.pagination
    )
  }
  
  /// Creates or appends a character's comics given their ID and pagination.
  func fetchCharacterComics(
    id: Int,
    pagination: Pagination
  ) async {
    do {
      let results = try await self.characterComicsService.fetchCharacterComics(
        self.character.id,
        pagination.offset,
        pagination.limit
      )
      self.pagination.hasMorePages = !results.isEmpty
      if self.pagination.offset == 0 {
        self.comics = .completed(results)
      } else {
        guard case var .completed(completedComics) = self.comics else {
          return
        }
        results.forEach { completedComics.append($0) }
        self.comics = .completed(completedComics)
      }
    } catch {
      Logger.views.error("Error on \(#function):\(error)")
      self.comics = .error("There was a problem with fetching the characters")
    }
  }
  
  /// Fetches the next page of character comics when the first comic of the current page appears
  public func comicAppeared(_ comic: Comic) async {
    guard case let .completed(result) = self.comics,
          let row = result.firstIndex(of: comic) else {
      return
    }
    if self.pagination.shouldIncrementOffset(row) {
      self.pagination.incrementOffset()
      await fetchCharacterComics(
        id: self.character.id,
        pagination: self.pagination
      )
    }
  }
}
