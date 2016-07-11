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
    
    var isLoggingEnabled = false
    
    private init() {}
    
    public func enableLogging(enabled: Bool) {
        isLoggingEnabled = enabled
    }
}