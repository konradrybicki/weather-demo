import Foundation

enum LogLevel: String {
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

final class Logger {
    static func log(message: String, logLevel: LogLevel) {
        let date = Date().toString()
        print(date + .space() + logLevel.rawValue + .space() + message)
    }
}
