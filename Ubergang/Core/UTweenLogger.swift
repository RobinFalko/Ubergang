//
//  UTweenLogger.swift
//  Ubergang
//
//  Created by RF on 09/07/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import XCGLogger

class UTweenLogger {
    private init() {}
    
    static var isLoggingEnabled: Bool = {
        UTweenSetup.instance.isLoggingEnabled
    }()
    
    class func verbose(msg: String) {
        guard isLoggingEnabled else { return }
        XCGLogger.verbose(msg)
    }
    class func debug(msg: String) {
        guard isLoggingEnabled else { return }
        XCGLogger.debug(msg)
    }
    class func info(msg: String) {
        guard isLoggingEnabled else { return }
        XCGLogger.info(msg)
    }
    class func warning(msg: String) {
        guard isLoggingEnabled else { return }
        XCGLogger.warning(msg)
    }
    class func error(msg: String) {
        guard isLoggingEnabled else { return }
        XCGLogger.error(msg)
    }
    class func severe(msg: String) {
        guard isLoggingEnabled else { return }
        XCGLogger.severe(msg)
    }
}