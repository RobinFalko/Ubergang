//
//  Timer.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class Timer {
    open static let instance = Timer()
    
    fileprivate let id = "\(#file)_update"
    
    open static var delta:TimeInterval = TimeInterval(0)
    open static var time:TimeInterval = TimeInterval(0)
    fileprivate var lastUpdateTime:TimeInterval = TimeInterval(0)
    
    fileprivate init() {}
    
    func start() {
        self.lastUpdateTime = Date().timeIntervalSince1970
        
        Engine.instance.register(update, forKey: id)
    }
    
    
    func stop() {
        Engine.instance.unregister(id)
    }
    
    
    func update() {
        tick(Date().timeIntervalSince1970)
    }
    
    
    func tick(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0.0 {
            Timer.delta = 0
        } else {
            Timer.delta = currentTime - self.lastUpdateTime
        }
        
        self.lastUpdateTime = Date().timeIntervalSince1970
        
        Timer.time += Timer.delta
    }
}
