//
//  UTween.swift
//  UTween
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

open class UTween<T>: UTweenBase {
    
    var start: T!
    var end: T!
    
    internal var fromC: (() -> T)!
    internal var toC: (() -> T)!
    
    var updateValue: ((_ value: T) -> Void)!
    var updateValueAndProgress: ((_ value: T, _ progress: Double) -> Void)!
    
    var offset: Double?
    
    /**
     Initialize a generic `UTween` with a random id.
     
     Tweens any value with type T from start to end.
     
     This object needs to know how to compute interpolations from start to end, that for
     `func compute(value: Double) -> T` must be overriden.
     */
    public convenience init() {
        let id = "\(#file)_\(arc4random())_update"
        self.init(id: id)
    }
    
    /**
     Initialize a generic `UTween`.
     
     Tweens any value with type T from start to end.
     
     This object needs to know how to compute interpolations from start to end, that for 
     `func compute(value: Double) -> T` must be overriden.
     
     - Parameter id: The unique id of the Tween
     */
    public override init(id: String) {
        super.init(id: id)
    }
    
    override open var progress: Double {
        set {
            time = newValue * duration
            
            easeValue = currentEase.function(time, 0.0, 1.0, duration)
            
            if let offset = offset {
                easeValue = fmod(easeValue + offset, 1.0)
            }
            
            let computedValue = compute(easeValue)
            
            updateValue?( computedValue)
            updateValueAndProgress?( computedValue, newValue )
            
            super.progress = newValue
        }
        get {
            return time / duration
        }
    }
    
    func compute(_ value: Double) -> T {
        //should be overriden
        
        return fromC()
    }
    
    //override Tweenable methods
    override open func kill() {
        super.kill()
        
        fromC = nil
        updateValue = nil
        updateValueAndProgress = nil
        complete = nil
    }
    
    @discardableResult
    override open func reference(_ value: TweenMemoryReference) -> Self {
        reference = value
        
        return self
    }
}


extension UTween {
    // -
    public func from(_ from: T, to: T) -> Self {
        self.fromC = {from}
        self.toC = {to}
        
        return self.duration(duration)
    }
    
    public func from(_ from: @escaping () -> T, to: @escaping () -> T) -> Self {
        self.fromC = from
        self.toC = to
        
        return self.duration(duration)
    }
    
    public func from(_ from: @escaping () -> T, to: T) -> Self {
        self.fromC = from
        self.toC = {to}
        
        return self.duration(duration)
    }
    
    public func from(_ from: T, to: @escaping () -> T) -> Self {
        self.fromC = {from}
        self.toC = to
        
        return self.duration(duration)
    }
    
    
    @discardableResult
    public func update(_ value: @escaping (T) -> Void) -> Self {
        updateValue = value
        
        return self
    }
    
    
    @discardableResult
    public func update(_ value: @escaping (T, Double) -> Void) -> Self {
        updateValueAndProgress = value
        
        return self
    }
    
    @discardableResult
    public func ease(_ ease: Ease) -> Self {
        self.ease = ease
        self.currentEase = ease
        return self
    }
    
    @discardableResult
    public func offset(_ value: Double) -> Self {
        self.offset = value
        return self
    }
}
