import Foundation

public enum LoadState<Result: Equatable>: Equatable {
  case none
  case loading
  case completed(Result)
  case error(String)
}
