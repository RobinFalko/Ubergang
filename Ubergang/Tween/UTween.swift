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
    
    var start: T!
    var end: T!
    
    var from: (() -> T)!
    var to: (() -> T)!
    
    var updateValue: ((value: T) -> Void)!
    var updateValueAndProgress: ((value: T, progress: Double) -> Void)!
    
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
        
        return from()
    }
    
    //override Tweenable methods
    override public func kill() {
        super.kill()
        
        from = nil
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
    // -
    public func to(to: () -> T, from: () -> T, update: (T) -> Void) -> Self {
        
        self.to(to)
            .from(from)
            .update(update)
        
        end = to()
        start = from()
        
        return self
    }
    
    public func to(to: T, from: () -> T, update: (T) -> Void) -> Self {
        
        self.to(to)
            .from(from)
            .update(update)
        
        end = to
        start = from()
        
        return self
    }
    
    public func to(to: () -> T, from: T, update: (T) -> Void) -> Self {
        
        self.to(to)
            .from(from)
            .update(update)
        
        end = to()
        start = from
        
        return self
    }
    
    public func to(to: T, from: T, update: (T) -> Void) -> Self {
        
        self.to(to)
            .from(from)
            .update(update)
        
        end = to
        start = from
        
        return self
    }
    
    // -
    public func to(to: () -> T, from: () -> T, update: (T, Double) -> Void) -> Self {
        
        self.to(to)
            .from(from)
            .update(update)
        
        end = to()
        start = from()
        
        return self
    }
    
    public func to(to: T, from: () -> T, update: (T, Double) -> Void) -> Self {
        
        self.to(to)
            .from(from)
            .update(update)
        
        end = to
        start = from()
        
        return self
    }
    
    public func to(to: () -> T, from: T, update: (T, Double) -> Void) -> Self {
        
        self.to(to)
            .from(from)
            .update(update)
        
        end = to()
        start = from
        
        return self
    }
    
    public func to(to: T, from: T, update: (T, Double) -> Void) -> Self {
        
        self.to(to)
            .from(from)
            .update(update)
        
        end = to
        start = from
        
        return self
    }
    
    
    // -
    public func to(to: () -> T, from: () -> T, update: (T) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    
    public func to(to: T, from: () -> T, update: (T) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    
    public func to(to: () -> T, from: T, update: (T) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    
    public func to(to: T, from: T, update: (T) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    // -
    public func to(to: () -> T, from: () -> T, update: (T, Double) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(to: T, from: () -> T, update: (T, Double) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(to: () -> T, from: T, update: (T, Double) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(to: T, from: T, update: (T, Double) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    // -
    public func to(to: () -> T, from: () -> T, update: (T) -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, from: () -> T, update: (T) -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: () -> T, from: T, update: (T) -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, from: T, update: (T) -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update)
            .duration(duration)
        
        return self
    }
    
    // -
    public func to(to: () -> T, from: () -> T, update: (T, Double) -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, from: () -> T, update: (T, Double) -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: () -> T, from: T, update: (T, Double) -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, from: T, update: (T, Double) -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update)
            .duration(duration)
        
        return self
    }
    
    // -
    public func to(to: () -> T, from: () -> T, update: (T) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, from: () -> T, update: (T) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func to(to: () -> T, from: T, update: (T) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, from: T, update: (T) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    // -
    public func to(to: () -> T, from: () -> T, update: (T, Double) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, from: () -> T, update: (T, Double) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func to(to: () -> T, from: T, update: (T, Double) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func to(to: T, from: T, update: (T, Double) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    
    // -
    public func to(value: () -> T) -> Self {
        to = value
        
        return self
    }
    
    public func to(value: T) -> Self {
        to = {value}
        
        return self
    }
    
    public func from(value: () -> T) -> Self {
        from = value
        
        return self
    }
    
    public func from(value: T) -> Self {
        from = {value}
        
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