import Foundation

/// Services contain domain-specific sub-services that handle external sources like data retrieval, Apple APIs
public struct Services {
  public let characterComicsService: CharacterComicsService
  public let marvelCharactersService: MarvelCharactersService
  
  init(
    characterComicsService: CharacterComicsService,
    marvelCharactersService: MarvelCharactersService
  ) {
    self.characterComicsService = characterComicsService
    self.marvelCharactersService = marvelCharactersService
  }
}

public extension Services {
  static var live = Services(
    characterComicsService: CharacterComicsService.live,
    marvelCharactersService: MarvelCharactersService.live
  )
}

public extension Services {
  static var mock = Services(
    characterComicsService: CharacterComicsService.mock,
    marvelCharactersService: MarvelCharactersService.mock
  )
}
