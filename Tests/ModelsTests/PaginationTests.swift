import XCTest
@testable import Models
@testable import Mocks

final class PaginationTests: XCTestCase {
  func testInitializer() {
    let pagination = Pagination()
    XCTAssertEqual(pagination.limit, Pagination.defaultLimit)
  }
  
  func testIncrementOffset() throws {
    var pagination = Pagination()
    pagination.incrementOffset()
    XCTAssertEqual(pagination.offset, pagination.limit)
  }
  
  func testReset() throws {
    var pagination = Pagination()
    pagination.incrementOffset()
    pagination.reset()
    XCTAssertTrue(pagination.hasMorePages)
    XCTAssertEqual(pagination.offset, 0)
  }
  
  func testShouldIncrementOffset() throws {
    var pagination = Pagination()
    // Should increment offset when row is 1
    var row = 0
    XCTAssertFalse(pagination.shouldIncrementOffset(row))
    XCTAssertEqual(pagination.offset, 0)
    row += 1
    XCTAssertTrue(pagination.shouldIncrementOffset(row))
    pagination.incrementOffset()
    XCTAssertEqual(pagination.offset, pagination.limit)
    
    // Should increment offset when row is (limit + 1)
    row += pagination.limit
    XCTAssertTrue(pagination.shouldIncrementOffset(row))
    pagination.incrementOffset()
    XCTAssertEqual(pagination.offset, pagination.limit * 2)
   
    // When going back to row (limit + 1), it should not increment offset
    row = pagination.limit + 1
    XCTAssertFalse(pagination.shouldIncrementOffset(row))
    
    // Should increment offset when row is (limit * 2 + 1)
    row = (pagination.limit * 2) + 1
    XCTAssertTrue(pagination.shouldIncrementOffset(row))
    pagination.incrementOffset()
    XCTAssertEqual(pagination.offset, pagination.limit * 3)
  }
}
