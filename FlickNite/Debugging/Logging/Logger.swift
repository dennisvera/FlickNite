//
//  Logger.swift
//  FlickNite
//
//  Created by Dennis Vera on 5/28/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import CocoaLumberjack

final class Logger {
    
    // Define Log Level
    static let defaultLogLevel: DDLogLevel = .all
    
    // MARK: - Class Methods
    
    class func setup() {
        // Configure TTY Logger
        guard let loggerSharedInstance = DDTTYLogger.sharedInstance else { return }
        loggerSharedInstance.logFormatter = LogFormatter()
        
        // Add TTY Logger
        DDLog.add(loggerSharedInstance, with: defaultLogLevel)
    }
}
