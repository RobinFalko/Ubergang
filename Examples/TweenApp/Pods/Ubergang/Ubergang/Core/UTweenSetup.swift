//
//  UTweenSetup.swift
//  Ubergang
//
//  Created by RF on 11/07/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class UTweenSetup {
    open static let instance = UTweenSetup()
    
    fileprivate var isLoggingEnabled = false
    
    internal lazy var logger: UTweenLoggable? = {
        guard UTweenSetup.instance.isLoggingEnabled else { return nil }
        return UTweenLogger()
    }()
    
    fileprivate init() {}
    
    open func enableLogging(_ enabled: Bool) {
        isLoggingEnabled = enabled
    }
    
    open func enableLogging(_ enabled: Bool, withLogger logger: UTweenLoggable) {
        enableLogging(enabled)
        self.logger = logger
    }
}
