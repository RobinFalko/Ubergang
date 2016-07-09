//
//  UTweenLogger.swift
//  Ubergang
//
//  Created by RF on 09/07/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//


class UTweenLogger {
    static let instance: UTweenLogger = UTweenLogger()
    
    private init() {}
    
    func verbose(msg: String) {
        if objc_getClass("XCGLogger") != nil {
            XCGLogger.verbose(msg)
        } else {
            print("\(msg)")
        }
    }
    func debug(msg: String) {
        if objc_getClass("XCGLogger") != nil {
            XCGLogger.debug(msg)
        } else {
            print("\(msg)")
        }
    }
    func info(msg: String) {
        if objc_getClass("XCGLogger") != nil {
            XCGLogger.info(msg)
        } else {
            print("\(msg)")
        }
    }
    func warning(msg: String) {
        if objc_getClass("XCGLogger") != nil {
            XCGLogger.warning(msg)
        } else {
            print("\(msg)")
        }
    }
    func error(msg: String) {
        if objc_getClass("XCGLogger") != nil {
            XCGLogger.error(msg)
        } else {
            print("\(msg)")
        }
    }
    func severe(msg: String) {
        if objc_getClass("XCGLogger") != nil {
            XCGLogger.severe(msg)
        } else {
            print("\(msg)")
        }
    }
}