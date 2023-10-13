import Combine
import XCTest
import Models
import Services
@testable import MarvelCharacters

final class MarvelCharactersViewModelTests: XCTestCase {
  private var cancellables: Set<AnyCancellable> = []
  
  func mockViewModel() throws -> MarvelCharactersViewModel {
    MarvelCharactersViewModel(
      services: Services.mock
    )
  }
  
  func testLoadMarvelCharacters() throws {
    let viewModel = try self.mockViewModel()
    let expectation = XCTestExpectation(description: "Marvel characters completed loading")
    viewModel.$marvelCharacters
      .dropFirst(2)
      .sink { loadState in
        guard case let .completed(result) = loadState else {
          XCTFail("Expected .completed, but received \(loadState)")
          return
        }
        XCTAssertEqual(result.count, 20)
        expectation.fulfill()
      }
      .store(in: &cancellables)
    viewModel.loadMarvelCharacters()
    wait(for: [expectation], timeout: 1)
  }
  
  func testFetchMarvelCharacters() throws {
    let viewModel = try self.mockViewModel()
    let expectation = XCTestExpectation(description: "Marvel characters completed fetching")
    viewModel.$marvelCharacters
      .dropFirst()
      .sink { loadState in
        guard case let .completed(result) = loadState else {
          XCTFail("Expected .completed, but received \(loadState)")
          return
        }
        XCTAssertEqual(result[0].id, 1011334)
        XCTAssertEqual(result[1].id, 1017100)
        XCTAssertEqual(result[2].id, 1009144)
        expectation.fulfill()
      }
      .store(in: &cancellables)
    viewModel.fetchMarvelCharacters(pagination: Pagination())
    wait(for: [expectation], timeout: 1)
  }
  
  @MainActor 
  func testCharacterTapped() throws {
    let viewModel = try self.mockViewModel()
    viewModel.characterTapped(try MarvelCharacter.mock)
    guard case let .characterComics(characterComicsViewModel) = viewModel.destination else {
      XCTFail("Expected .characterComics, but received \(String(describing: viewModel.destination))")
      return
    }
    XCTAssertEqual(characterComicsViewModel.character.id, 1011334)
  }
  
  func testCharacterAppeared() throws {
    let viewModel = try self.mockViewModel()
    var firstComic: MarvelCharacter?
    var secondComic: MarvelCharacter?
    
    let expectation = XCTestExpectation(description: "Marvel characters completed fetching")
    viewModel.$marvelCharacters
      .dropFirst()
      .sink { loadState in
        guard case let .completed(result) = loadState else {
          XCTFail("Expected .completed, but received \(loadState)")
          return
        }
        if firstComic == nil {
          XCTAssertEqual(result.count, 20)
          firstComic = result[0]
        } else if secondComic != nil {
          XCTAssertEqual(result.count, 40)
        }
        expectation.fulfill()
      }
      .store(in: &cancellables)
    viewModel.fetchMarvelCharacters(pagination: Pagination())
    wait(for: [expectation], timeout: 1)
    
    guard let firstComic else {
      XCTFail("First Comic expected, but received nil")
      return
    }
    viewModel.characterAppeared(firstComic)
    XCTAssertEqual(viewModel.pagination.offset, 0)
    
    secondComic = try [MarvelCharacter].mock[1]
    viewModel.characterAppeared(secondComic!)
    XCTAssertEqual(viewModel.pagination.offset, viewModel.pagination.limit)
  }
  
  func testResetDestination() throws {
    let viewModel = try self.mockViewModel()
    viewModel.resetDestination()
    XCTAssertNil(viewModel.destination)
  }
}
