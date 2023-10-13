import XCTest
import Models
import Services
@testable import CharacterComics

@MainActor
final class CharacterComicsViewModelTests: XCTestCase {
  func mockViewModel() throws -> CharacterComicsViewModel {
    CharacterComicsViewModel(
      character: try MarvelCharacter.mock,
      characterComicsService: CharacterComicsService.mock
    )
  }
  
  func testLoadMarvelCharacters() async throws {
    let viewModel = try self.mockViewModel()
    await viewModel.loadComics()
    guard case let .completed(result) = viewModel.comics else {
      XCTFail("Expected .completed, but received \(viewModel.comics)")
      return
    }
    XCTAssertEqual(result.count, 20)
  }
  
  func testFetchMarvelCharacters() async throws {
    let viewModel = try self.mockViewModel()
    await viewModel.fetchCharacterComics(
      id: viewModel.character.id,
      pagination: Pagination()
    )
    guard case let .completed(result) = viewModel.comics else {
      XCTFail("Expected .completed, but received \(viewModel.comics)")
      return
    }
    XCTAssertEqual(result.count, 20)
    XCTAssertEqual(result[0].id, 1689)
    XCTAssertEqual(result[1].id, 1886)
    XCTAssertEqual(result[2].id, 1332)
  }
  
  func testComicAppeared() async throws {
    let viewModel = try self.mockViewModel()
    await viewModel.fetchCharacterComics(
      id: viewModel.character.id,
      pagination: Pagination()
    )
    guard case let .completed(firstResult) = viewModel.comics else {
      XCTFail("Expected .completed, but received \(viewModel.comics)")
      return
    }
    
    XCTAssertEqual(firstResult.count, 20)
    let firstComic = try [Comic].mock[0]
    await viewModel.comicAppeared(firstComic)
    XCTAssertEqual(viewModel.pagination.offset, 0)
    
    let secondComic = try [Comic].mock[1]
    await viewModel.comicAppeared(secondComic)
    XCTAssertEqual(viewModel.pagination.offset, viewModel.pagination.limit)
    guard case let .completed(secondResult) = viewModel.comics else {
      XCTFail("Expected .completed, but received \(viewModel.comics)")
      return
    }
    XCTAssertEqual(secondResult.count, 40)
  }
}
