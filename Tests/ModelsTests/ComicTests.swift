import XCTest
@testable import Models
@testable import Mocks

final class ComicTests: XCTestCase {
  let dateFormatter = DateFormatter()
  
  func testCodability() throws {
    let mockComic = try Comic.mock
    XCTAssertEqual(mockComic.id, 1689)
    XCTAssertEqual(mockComic.title, "Official Handbook of the Marvel Universe (2004) #10 (MARVEL KNIGHTS)")
    XCTAssertEqual(mockComic.issueNumber, 10)
    
    let mockComics = try [Comic].mock
    XCTAssertEqual(mockComics[0].id, 1689)
    XCTAssertEqual(mockComics[1].id, 1886)
    XCTAssertEqual(mockComics[2].id, 1332)
  }
  
  func testThumbnailUrls() throws {
    let mockComic = try Comic.mock
    XCTAssertEqual(
      mockComic.thumbnailUrl,
      URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/30/4bc64df4105b9.jpg")
    )
  }
  
  func testOnsaledates() throws {
    let mockComic = try Comic.mock
    // Onsale date should equal "2029-12-31T00:00:00-0500"
    let calendar = Calendar(identifier: .gregorian)
    var dateComponents = DateComponents()
    dateComponents.year = 2029
    dateComponents.month = 12
    dateComponents.day = 31
    dateComponents.hour = 0
    dateComponents.minute = 0
    dateComponents.second = 0
    dateComponents.timeZone = TimeZone(secondsFromGMT: -5 * 60 * 60)
    let onsaleDate = calendar.date(from: dateComponents) ?? nil
    XCTAssertEqual(mockComic.onsaleDate, onsaleDate)
  }
}
