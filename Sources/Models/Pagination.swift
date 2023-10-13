public struct Pagination: Equatable {
  public static let defaultLimit = 20
  public var hasMorePages = true
  public let limit: Int
  public private(set) var offset: Int = 0
  
  public init(_ limit: Int = Self.defaultLimit) {
    self.limit = limit
  }
  
  public mutating func incrementOffset() {
    offset += limit
  }
  
  public mutating func reset() {
    hasMorePages = true
    offset = 0
  }

  /// Should only increment the offset when:
  /// - row is greater than the current offset
  /// - row is the first item in the page
  /// - `hasMorePages` is true
  public func shouldIncrementOffset(_ row: Int) -> Bool {
    guard row >= offset else { return false }
    let isFirstItemInPage = row % limit == 1
    return isFirstItemInPage && hasMorePages
  }
}
