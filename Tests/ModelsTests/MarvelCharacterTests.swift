import XCTest
@testable import Models
@testable import Mocks

final class MarvelCharacterTests: XCTestCase {
  func testCodability() throws {
    let mockCharacter = try MarvelCharacter.mock
    XCTAssertEqual(mockCharacter.id, 1011334)
    XCTAssertEqual(mockCharacter.name, "3-D Man")
    
    let mockCharacters = try [MarvelCharacter].mock
    XCTAssertEqual(mockCharacters[0].id, 1011334)
    XCTAssertEqual(mockCharacters[1].id, 1017100)
    XCTAssertEqual(mockCharacters[2].id, 1009144)
  }
  
  func testThumbnailUrls() throws {
    let mockCharacter = try MarvelCharacter.mock
    XCTAssertEqual(
      mockCharacter.thumbnailUrl,
      URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
    )
  }
}
