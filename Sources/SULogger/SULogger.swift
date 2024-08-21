//
//  SULogger.swift
//  SULogger
//
//  Created by Sinan Ulusoy on 8.07.2024.
//

import Foundation

// MARK: - LogLevel Protocol

/// Protocol defining the severity level of log messages.
public protocol SULogLevelProtocol {
    var rawValue: Int { get }
    var prefix: String { get }
    var icon: String { get }
}

// MARK: - LogLevel Enum

/// Enum implementing the SULogLevelProtocol for standard log levels.
public enum SULogLevel: Int, SULogLevelProtocol {
    case debug = 0
    case info
    case warning
    case error
    
    /// Provides a prefix string for each log level.
    public var prefix: String {
        switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        }
    }
    
    /// Provides a icon string for each log level.
    public var icon: String {
        switch self {
        case .debug: return "🔍"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "🚫"
        }
    }
}

// MARK: - Logger Protocol

/// Protocol defining the essential methods and properties for a logger.
public protocol SULoggerProtocol {
    static var dateFormatter: DateFormatter { get }
    static var minimumLogLevel: SULogLevel { get }
    
    static func setMinimumLogLevel(_ level: SULogLevel)
    static func log(
        _ level: SULogLevel,
        message: String,
        fileName: String,
        line: Int,
        funcName: String
    )
}

// MARK: - Logger Class

/// Logger class to handle logging messages with different severity levels.
public class SULogger: SULoggerProtocol {
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }()
    
    public static var minimumLogLevel: SULogLevel = .debug
    
    /// Sets the minimum log level to filter messages.
    ///
    /// - Parameter level: The minimum `SULogLevel` to log.
    public static func setMinimumLogLevel(_ level: SULogLevel) {
        minimumLogLevel = level
    }
    
    /// Logs a message with the specified log level.
    ///
    /// - Parameters:
    ///   - level: The severity level of the log message.
    ///   - message: The message to log.
    ///   - fileName: The name of the file from which the log is called.
    ///   - line: The line number from which the log is called.
    ///   - funcName: The function name from which the log is called.
    public static func log(
        _ level: SULogLevel,
        message: String,
        fileName: String = #file,
        line: Int = #line,
        funcName: String = #function
    ) {
        guard level.rawValue >= minimumLogLevel.rawValue else { return }
        
        let timestamp = dateFormatter.string(from: Date())
        let fileName = URL(fileURLWithPath: fileName).lastPathComponent
        
        let logMetaData = "\(level.icon) [\(level.prefix)] [\(timestamp)] [\(fileName):\(line) \(funcName)]"
        let logMessage = "\(logMetaData) \(message)"
        let line = String(repeating: "=", count: logMetaData.count+1)

        print(line)
        print(logMessage)
        print(line)
        print("\n")
    }
}

// MARK: - Log level implementations

/// Extension for `SULoggerProtocol` to provide convenience methods for different log levels.
public extension SULoggerProtocol {
    static func debug(
        _ message: String,
        fileName: String = #file,
        line: Int = #line,
        funcName: String = #function
    ) {
        log(.debug, message: message, fileName: fileName, line: line, funcName: funcName)
    }
    
    static func info(
        _ message: String,
        fileName: String = #file,
        line: Int = #line,
        funcName: String = #function
    ) {
        log(.info, message: message, fileName: fileName, line: line, funcName: funcName)
    }
    
    static func warning(
        _ message: String,
        fileName: String = #file,
        line: Int = #line,
        funcName: String = #function
    ) {
        log(.warning, message: message, fileName: fileName, line: line, funcName: funcName)
    }
    
    static func error(
        _ message: String,
        fileName: String = #file,
        line: Int = #line,
        funcName: String = #function
    ) {
        log(.error, message: message, fileName: fileName, line: line, funcName: funcName)
    }
}
