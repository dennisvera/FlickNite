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
        guard let loggerSharedInstance = DDTTYLogger.sharedInstance else { return }
        
        // Configure os_log Logger
        loggerSharedInstance.logFormatter = LogFormatter()
        
        // Add os_log Logger
        DDLog.add(loggerSharedInstance, with: defaultLogLevel)
    }
}
