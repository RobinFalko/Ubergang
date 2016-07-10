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
    
    class func verbose(msg: String) {
        XCGLogger.verbose(msg)
    }
    class func debug(msg: String) {
        XCGLogger.debug(msg)
    }
    class func info(msg: String) {
        XCGLogger.info(msg)
    }
    class func warning(msg: String) {
        XCGLogger.warning(msg)
    }
    class func error(msg: String) {
        XCGLogger.error(msg)
    }
    class func severe(msg: String) {
        XCGLogger.severe(msg)
    }
}