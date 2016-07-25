//
//  UTweenSetup.swift
//  Ubergang
//
//  Created by RF on 11/07/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class UTweenSetup {
    public static let instance = UTweenSetup()
    
    private var isLoggingEnabled = false
    
    internal lazy var logger: UTweenLoggable? = {
        guard UTweenSetup.instance.isLoggingEnabled else { return nil }
        return UTweenLogger()
    }()
    
    private init() {}
    
    public func enableLogging(enabled: Bool) {
        isLoggingEnabled = enabled
    }
    
    public func enableLogging(enabled: Bool, withLogger logger: UTweenLoggable) {
        enableLogging(enabled)
        self.logger = logger
    }
}