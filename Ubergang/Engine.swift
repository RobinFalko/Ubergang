//
//  Engine.swift
//  Tween
//
//  Created by RF on 09/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

public class Engine: NSObject {
    public typealias Closure = () -> Void
    
    var closures = [String : Closure]()
    
    var mapTable = NSMapTable(keyOptions: .StrongMemory, valueOptions: .WeakMemory)
    
    public static var instance: Engine = {
        let engine = Engine()
        engine.start()
        return engine
    }()
    
    func start() {
        let displayLink = CADisplayLink(target: self, selector: Selector("update"))
        displayLink.frameInterval = 1
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
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
    }
    
    
    func register(loopable: WeaklyLoopable, forKey key: String) {
        mapTable.setObject(loopable as? AnyObject, forKey: key)
    }
    
    
    func unregister(key: String) {
        mapTable.removeObjectForKey(key)
        
        closures.removeValueForKey(key)
    }
}