//
//  UTweenLoggable.swift
//  Ubergang
//
//  Created by RF on 18/07/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import XCGLogger

public protocol UTweenLoggable {
    func verbose(msg: String, function: String, file: String, line: Int)
    func debug(msg: String, function: String, file: String, line: Int)
    func info(msg: String, function: String, file: String, line: Int)
    func warning(msg: String, function: String, file: String, line: Int)
    func error(msg: String, function: String, file: String, line: Int)
}


extension UTweenLoggable {
    func verbose(msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        XCGLogger.verbose(msg)
    }
    
    func debug(msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        XCGLogger.debug(msg)
    }
    
    func info(msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        XCGLogger.info(msg)
    }
    
    func warning(msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        XCGLogger.warning(msg)
    }
    
    func error(msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        XCGLogger.error(msg)
    }
}


class UTweenLogger: UTweenLoggable {}