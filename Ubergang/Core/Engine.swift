//
//  Engine.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 09/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

open class Engine: NSObject {
    public typealias Closure = () -> Void
    
    fileprivate var displayLink: CADisplayLink?
    
    var closures = [String : Closure]()
    
    var mapTable = NSMapTable<AnyObject, AnyObject>(keyOptions: NSPointerFunctions.Options.strongMemory, valueOptions: NSPointerFunctions.Options.weakMemory)
    
    public static var instance: Engine = {
        let engine = Engine()
        engine.start()
        return engine
    }()
    
    func start() {
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(Engine.update))
            displayLink!.add(to: .current, forMode: .common)
        }
    }
    
    func stop() {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink = nil
    }
    
    @objc func update() {
        let enumerator = mapTable.objectEnumerator()
        while let any: AnyObject = enumerator?.nextObject() as AnyObject? {
            if let loopable = any as? WeaklyLoopable {
                loopable.loopWeakly()
            }
        }
        
        for (_, closure) in closures {
            closure()
        }
    }
    
    
    func register(_ closure: @escaping Closure, forKey key: String) {
        closures[key] = closure
        
        start()
    }
    
    
    func register(_ loopable: WeaklyLoopable, forKey key: String) {
        mapTable.setObject(loopable as AnyObject?, forKey: key as AnyObject?)
        
        start()
    }
    
    
    func unregister(_ key: String) {
        mapTable.removeObject(forKey: key as AnyObject?)
        
        closures.removeValue(forKey: key)
        
        if mapTable.count == 0 && closures.isEmpty {
            stop()
        }
    }
    
    
    func contains(_ key: String) -> Bool {
        return mapTable.object(forKey: key as AnyObject?) != nil || closures[key] != nil
    }
}
