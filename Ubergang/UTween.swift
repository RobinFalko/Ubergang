//
//  UTween.swift
//  UTween
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

public class UTween<T>: UTweenBase {
    
    var from: T!
    var to: T!
    
    var current: (() -> T)!
    var updateValue: ((value: T) -> Void)!
    var updateValueAndProgress: ((value: T, progress: Double) -> Void)!
    
    public override init(id: String) {
        super.init(id: id)
    }
    
    override public var progress: Double {
        set {
            time = newValue * duration
            
            easeValue = ease(t: time, b: 0.0, c: 1.0, d: duration)
            
            updateValue?( value: compute(easeValue) )
            updateValueAndProgress?( value: compute(easeValue), progress: newValue )
            
            super.progress = newValue
        }
        get {
            return time / duration
        }
    }
    
    func compute(value: Double) -> T {
        //should be overriden
        
        return current()
    }
    
    //override Tweenable methods
    override public func kill() {
        super.kill()
        
        current = nil
        updateValue = nil
        updateValueAndProgress = nil
        complete = nil
    }
    
    override public func memoryReference(value: TweenMemoryReference) -> Self {
        memoryReference = value
        
        return self
    }
}


extension UTween {
    public func to(to: T, current: () -> T, update: (T) -> Void) -> Self {
        
        self.to = to
        
        self.current(current)
            .update(update)
        
        from = current()
        
        return self
    }
    
    public func to(to: T, current: () -> T, update: (T, Double) -> Void) -> Self {
        
        self.to = to
        
        self.current(current)
            .update(update)
        
        from = current()
        
        return self
    }
    
    public func to(to: T, current: () -> T, update: (T) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, current: current, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(to: T, current: () -> T, update: (T, Double) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, current: current, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(to: T, current: () -> T, update: (T) -> Void, duration: Double) -> Self {
        
        self.to(to, current: current, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, current: () -> T, update: (T, Double) -> Void, duration: Double) -> Self {
        
        self.to(to, current: current, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, current: () -> T, update: (T) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, current: current, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, current: () -> T, update: (T, Double) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, current: current, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    
    public func current(value: () -> T) -> Self {
        current = value
        
        return self
    }
    
    
    public func update(value: (T) -> Void) -> Self {
        updateValue = value
        
        return self
    }
    
    
    public func update(value: (T, Double) -> Void) -> Self {
        updateValueAndProgress = value
        
        return self
    }
    
    public func duration(value: Double) -> Self {
        initialDuration = value
        duration = value
        durationTotal = value
        
        return self
    }
    
    public func ease(ease: Easing) -> Self {
        self.ease = ease
        return self
    }
}