//
//  Engine.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 09/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

public class Engine: NSObject {
    public typealias Closure = () -> Void
    
    private var displayLink: CADisplayLink?
    
    var closures = [String : Closure]()
    
    var mapTable = NSMapTable(keyOptions: .StrongMemory, valueOptions: .WeakMemory)
    
    public static var instance: Engine = {
        let engine = Engine()
        engine.start()
        return engine
    }()
    
    func start() {
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(Engine.update))
            displayLink!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        }
    }
    
    func stop() {
        displayLink?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        displayLink = nil
    }
    
    func update() {
        let enumerator = mapTable.objectEnumerator()
        while let any: AnyObject = enumerator?.nextObject() {
            if let loopable = any as? WeaklyLoopable {
                loopable.loopWeakly()
            }
        }
        
        for (_, closure) in closures {
            closure()
        }
    }
    
    
    func register(closure: Closure, forKey key: String) {
        closures[key] = closure
        
        start()
    }
    
    
    func register(loopable: WeaklyLoopable, forKey key: String) {
        mapTable.setObject(loopable as? AnyObject, forKey: key)
        
        start()
    }
    
    
    func unregister(key: String) {
        mapTable.removeObjectForKey(key)
        
        closures.removeValueForKey(key)
        
        if mapTable.count == 0 && closures.isEmpty {
            stop()
        }
    }
    
    
    func contains(key: String) -> Bool {
        return mapTable.objectForKey(key) != nil || closures[key] != nil
    }
}