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
    
    var from: (() -> T)!
    var to: (() -> T)!
    
    var updateValue: ((_ value: T) -> Void)!
    var updateValueAndProgress: ((_ value: T, _ progress: Double) -> Void)!
    
    var offset: Double?
    
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
            
            easeValue = ease(time, 0.0, 1.0, duration)
            
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
        
        return from()
    }
    
    //override Tweenable methods
    override open func kill() {
        super.kill()
        
        from = nil
        updateValue = nil
        updateValueAndProgress = nil
        complete = nil
    }
    
    override open func memoryReference(_ value: TweenMemoryReference) -> Self {
        memoryReference = value
        
        return self
    }
}


extension UTween {
    // -
    public func to(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (T) -> Void) -> Self {
        
        _ = self.to(to)
            .from(from)
            .update(update)
        
        end = to()
        start = from()
        
        return self
    }
    
    public func to(_ to: T, from: @escaping () -> T, update: @escaping (T) -> Void) -> Self {
        
        _ = self.to(to)
            .from(from)
            .update(update)
        
        end = to
        start = from()
        
        return self
    }
    
    public func to(_ to: @escaping () -> T, from: T, update: @escaping (T) -> Void) -> Self {
        
        _ = self.to(to)
            .from(from)
            .update(update)
        
        end = to()
        start = from
        
        return self
    }
    
    public func to(_ to: T, from: T, update: @escaping (T) -> Void) -> Self {
        
        _ = self.to(to)
            .from(from)
            .update(update)
        
        end = to
        start = from
        
        return self
    }
    
    // -
    public func to(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (T, Double) -> Void) -> Self {
        
        _ = self.to(to)
            .from(from)
            .update(update)
        
        end = to()
        start = from()
        
        return self
    }
    
    public func to(_ to: T, from: @escaping () -> T, update: @escaping (T, Double) -> Void) -> Self {
        
        _ = self.to(to)
            .from(from)
            .update(update)
        
        end = to
        start = from()
        
        return self
    }
    
    public func to(_ to: @escaping () -> T, from: T, update: @escaping (T, Double) -> Void) -> Self {
        
        _ = self.to(to)
            .from(from)
            .update(update)
        
        end = to()
        start = from
        
        return self
    }
    
    public func to(_ to: T, from: T, update: @escaping (T, Double) -> Void) -> Self {
        
        _ = self.to(to)
            .from(from)
            .update(update)
        
        end = to
        start = from
        
        return self
    }
    
    
    // -
    public func to(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (T) -> Void, complete: @escaping () -> Void) -> Self {
        
        _ = self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    
    public func to(_ to: T, from: @escaping () -> T, update: @escaping (T) -> Void, complete: @escaping () -> Void) -> Self {
        
        _ = self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    
    public func to(_ to: @escaping () -> T, from: T, update: @escaping (T) -> Void, complete: @escaping () -> Void) -> Self {
        
        _ = self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    
    public func to(_ to: T, from: T, update: @escaping (T) -> Void, complete: @escaping () -> Void) -> Self {
        
        _ = self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    // -
    public func to(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (T, Double) -> Void, complete: @escaping () -> Void) -> Self {
        
        _ = self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(_ to: T, from: @escaping () -> T, update: @escaping (T, Double) -> Void, complete: @escaping () -> Void) -> Self {
        
        _ = self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(_ to: @escaping () -> T, from: T, update: @escaping (T, Double) -> Void, complete: @escaping () -> Void) -> Self {
        
        _ = self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(_ to: T, from: T, update: @escaping (T, Double) -> Void, complete: @escaping () -> Void) -> Self {
        
        _ = self.to(to, from: from, update: update)
            .complete(complete)
        
        return self
    }
    
    // -
    public func to(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (T) -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update)
            .duration(duration)
    }
    
    public func to(_ to: T, from: @escaping () -> T, update: @escaping (T) -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update)
            .duration(duration)
    }
    
    public func to(_ to: @escaping () -> T, from: T, update: @escaping (T) -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update)
            .duration(duration)
    }
    
    public func to(_ to: T, from: T, update: @escaping (T) -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update)
            .duration(duration)
    }
    
    // -
    public func to(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (T, Double) -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update)
            .duration(duration)
    }
    
    public func to(_ to: T, from: @escaping () -> T, update: @escaping (T, Double) -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update)
            .duration(duration)
    }
    
    public func to(_ to: @escaping () -> T, from: T, update: @escaping (T, Double) -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update)
            .duration(duration)
    }
    
    public func to(_ to: T, from: T, update: @escaping (T, Double) -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update)
            .duration(duration)
    }
    
    // -
    public func to(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (T) -> Void, complete: @escaping () -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
    }
    
    public func to(_ to: T, from: @escaping () -> T, update: @escaping (T) -> Void, complete: @escaping () -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
    }
    
    public func to(_ to: @escaping () -> T, from: T, update: @escaping (T) -> Void, complete: @escaping () -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
    }
    
    public func to(_ to: T, from: T, update: @escaping (T) -> Void, complete: @escaping () -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
    }
    
    // -
    public func to(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (T, Double) -> Void, complete: @escaping () -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
    }
    
    public func to(_ to: T, from: @escaping () -> T, update: @escaping (T, Double) -> Void, complete: @escaping () -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
    }
    
    public func to(_ to: @escaping () -> T, from: T, update: @escaping (T, Double) -> Void, complete: @escaping () -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
    }
    
    public func to(_ to: T, from: T, update: @escaping (T, Double) -> Void, complete: @escaping () -> Void, duration: Double) -> Self {
        
        return self.to(to, from: from, update: update, complete:  complete)
            .duration(duration)
    }
    
    
    // -
    public func to(_ value: @escaping () -> T) -> Self {
        to = value
        
        return self
    }
    
    public func to(_ value: T) -> Self {
        to = {value}
        
        return self
    }
    
    public func from(_ value: @escaping () -> T) -> Self {
        from = value
        
        return self
    }
    
    public func from(_ value: T) -> Self {
        from = {value}
        
        return self
    }
    
    
    public func update(_ value: @escaping (T) -> Void) -> Self {
        updateValue = value
        
        return self
    }
    
    
    public func update(_ value: @escaping (T, Double) -> Void) -> Self {
        updateValueAndProgress = value
        
        return self
    }
    
    public func duration(_ value: Double) -> Self {
        initialDuration = value
        duration = value
        durationTotal = value
        
        return self
    }
    
    public func ease(_ ease: @escaping Easing) -> Self {
        self.ease = ease
        return self
    }
    
    public func offset(_ value: Double) -> Self {
        self.offset = value
        return self
    }
}
