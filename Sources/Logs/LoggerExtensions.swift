@_exported import OSLog

public extension Logger {
  private static var subsystem = Bundle.main.bundleIdentifier!
  static let views = Logger(subsystem: subsystem, category: "views")
  static let services = Logger(subsystem: subsystem, category: "services")
}
