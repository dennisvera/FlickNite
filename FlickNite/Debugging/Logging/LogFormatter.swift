//
//  LogFormatter.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import CocoaLumberjack

class LogFormatter: NSObject, DDLogFormatter {
    
    // MARK: - Properties
    
    private let dateFormatter: DateFormatter = {
        // Initialize Date Formatter
        let newDateFormatter = DateFormatter()
        
        // Configure Date Formatter
        newDateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
        
        return newDateFormatter
    }()
    
    // MARK: - DDLogFormatter
    
    func format(message logMessage: DDLogMessage) -> String? {
        // Helpers
        let logLevel: String
        
        switch logMessage.flag {
        case .error:
            logLevel = "ERROR"
        case .warning:
            logLevel = "WARNING"
        case .debug:
            logLevel = "DEBUG"
        case .info:
            logLevel = "INFO"
        default:
            logLevel = "VERBOSE"
        }
        
        // Helpers
        let message = logMessage.message
        let fileName = logMessage.fileName
        let line = logMessage.line
        let timeStamp = dateFormatter.string(from: logMessage.timestamp)
        
        if let function = logMessage.function {
            return "\(timeStamp) | \(fileName):\(line) - \(function) | [\(logLevel)] \(message)"
        } else {
            return "\(timeStamp) | \(fileName):\(line) | [\(logLevel)] \(message)"
        }
    }
}
