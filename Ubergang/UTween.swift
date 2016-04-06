//
//  UTween.swift
//  UTween
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

protocol WeaklyLoopable {
    func loopWeakly()
}

public enum TweenDirection {
    case Forward, Reverse
}

public class UTween<T> {
    let _id: String
        
    public var id: String {
        return _id
    }
    
    var from: T!
    var to: T!
    
    var current: (() -> T)!
    var updateValue: ((T) -> Void)!
    var updateValueAndProgress: ((T, Double) -> Void)!
    var complete: (() -> Void)?
    
    var tweenOptions: [TweenOptions]!
    
    var duration = 0.0
    var durationTotal = 0.0
    
    var ease: Easing = Ease.linear
    var easeValue = 0.0
    
    var absolute = false
    
    var time = 0.0
    
    var memoryReference: TweenMemoryReference = .Strong
    
    var direction: TweenDirection = .Forward
    
    public var progress: Double {
        set {
            time = newValue * duration
            easeValue = ease(t: time, b: 0.0, c: 1.0, d: duration)
            
            updateValue?( compute(easeValue) )
            updateValueAndProgress?( compute(easeValue), newValue )
        }
        get {
            return time / duration
        }
    }
    
    
    public init(id: String) {
        _id = id
        
        //TweenManager.registerTween(self)
        
        tweenOptions = [.Repeat(0)]
        
        _ = Timer()
    }
    
    deinit {
        print("deinit tween: \(id)")
    }
    
    private func registerLoop() {
        switch memoryReference {
        case .Strong:
            Engine.instance.register(loop, forKey: id)
        case .Weak:
            Engine.instance.register(self, forKey: id)
        }
    }
    
    private func unregisterLoop() {
        Engine.instance.unregister(id)
    }
    
    func compute(value: Double) -> T {
        //should be overriden
        
        return current()
    }
    
    func checkForStop() {
        var willStop = false
        
        if progress > 1.0 {
            progress = 1.0
            
            if tweenOptionYoyo() {
                return
            }
            
            if tweenOptionRepeat() {
                return
            }
            
            willStop = true
        }
        else if progress < 0 {
            progress = 0
            
            if tweenOptionRepeat() {
                return
            }
            
            willStop = true
        }
        
        if willStop {
            stop()
            complete?()
        }
    }
    
    func tweenOptionYoyo() -> Bool {
        if tweenOptions.contains(.Yoyo) {
            direction = .Reverse
            return true
        }
        
        return false
    }
    
    func tweenOptionRepeat() -> Bool {
        for tweenOption in tweenOptions {
            switch tweenOption {
            case .Repeat(let count):
                
                if count > 0 {
                    let index = tweenOptions.indexOf(.Repeat(count))
                    tweenOptions.removeAtIndex(index!)
                    tweenOptions.insert(.Repeat(count - 1), atIndex: index!)
                    
                    direction = .Forward
                    time = 0
                    return true
                }
            default:
                return false
            }
        }
        
        return false
    }
    
    
    public func ease(ease: Easing) -> Self {
        self.ease = ease
        return self
    }
    
    func loop() {
        
        //time += Timer.delta * Double(direction == .Forward ? 1 : -1)
        progress += Timer.delta / durationTotal * Double(direction == .Forward ? 1 : -1)
        
        checkForStop()
    }
}


extension UTween: Tweenable, WeaklyLoopable {
    
    func loopWeakly() {
        loop()
    }
    
    public func start() -> Self {
        switch direction {
        case .Forward:
            progress = 0.0
            break
        case .Reverse:
            progress = 1.0
            break
        }
        
        unregisterLoop()
        registerLoop()
        
        return self
    }
    
    public func stop() {
        print("stop")
        unregisterLoop()
        
        switch direction {
        case .Forward:
            progress = 1.0
            break
        case .Reverse:
            progress = 0.0
            break
        }
    }
    
    public func kill() {
        unregisterLoop()
        
        current = nil
        updateValue = nil
        updateValueAndProgress = nil
        complete = nil
        
        //TweenManager.unregisterTween(self)
        
        print("destroy: \(id)")
    }
    
    public func pause() {
        unregisterLoop()
    }
    
    public func resume() {
        registerLoop()
    }
    
    public func tweenDirection(direction: TweenDirection) -> Self {
        self.direction = direction
        
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
    
    
    public func complete(value: () -> Void) -> Self {
        complete = value
        
        return self
    }
    
    
    public func duration(value: Double) -> Self {
        duration = value
        durationTotal = value
        
        return self
    }
    
    
    public func memoryReference(value: TweenMemoryReference) -> Self {
        memoryReference = value
        
        return self
    }
    
    
    public func options(values: TweenOptions ...) -> Self {
        tweenOptions = values
        
        for value in values {
            
            switch value {
            case .Yoyo:
                durationTotal = duration * 0.5
                break
            case .Repeat(let count):
                let durationMultiplier = count == Int.max ? Int.max : count + 1
                durationTotal = duration * Double(durationMultiplier)
                break
            }
        }
        
        return self
    }
}