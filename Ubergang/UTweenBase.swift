//
//  UTweenBase.swift
//  Ubergang
//
//  Created by RF on 10/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class UTweenBase {
    private let _id: String
    
    public var id: String {
        return _id
    }
    
    var updateProgress: ((progress: Double) -> Void)?
    var updateProgressTotal: ((progressTotal: Double) -> Void)?
    var complete: (() -> Void)?
    var repeatCycleChange: ((repeatCycle: Int) -> Void)?
    
    var tweenOptions: [TweenOptions]!
    
    public var duration = 0.0
    var durationTotal = 0.0
    
    var ease: Easing = Linear.ease
    var easeValue = 0.0
    
    var absolute = false
    
    var time = 0.0
    var timeTotal = 0.0
    
    var memoryReference: TweenMemoryReference = .Strong
    
    var direction: TweenDirection = .Forward
    
    var initialDuration: Double = 0
    var initialRepeatCount: Int = 0
    var currentRepeatCycle: Int = 0
    
    public var isPlaying: Bool {
        return Engine.instance.contains(id)
    }
    
    public var progress: Double {
        get { return 0.0 }
        set {
            updateProgress?( progress: newValue )
        }
    }
    
    public var progressTotal: Double {
        set {
            
            timeTotal = newValue * durationTotal
            
            let repeatCount = tweenOptions.repeatCount()
            let cycles = Double(repeatCount + 1)
            
            if tweenOptions.contains(.Yoyo) {
                let yoyoMultiplier = 2.0 //two ways (forth and back)
                progress = Math.zigZag(newValue * cycles * yoyoMultiplier)
            } else {
                let mod = 1.000001 //slightly above 1.0 to sync progress and progressTotal at 1.0
                progress = fmod(newValue * cycles, mod)
            }
            
            let cycle = Int(newValue * cycles)
            if cycle <= repeatCount && currentRepeatCycle != cycle {
                currentRepeatCycle = cycle
                repeatCycleChange?(repeatCycle: cycle)
            }
            
            updateProgressTotal?( progressTotal: newValue )
        }
        get {
            return timeTotal / durationTotal
        }
    }
    
    init(id: String) {
        _id = id
        
        tweenOptions = [.Repeat(initialRepeatCount)]
        
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
    
    func loop() {
        progressTotal += Timer.delta / durationTotal * Double(direction == .Forward ? 1 : -1)
        
        checkForStop()
    }
    
    func checkForStop() {
        if progressTotal > 1.0 {
            progressTotal = 1.0
            stop()
            complete?()
        }
        
        if progressTotal < 0.0 {
            progressTotal = 0.0
            stop()
            complete?()
        }
    }
    
    func computeConfigs() {
        durationTotal = initialDuration
        duration = durationTotal
        
        if tweenOptions.containsYoyo() {
            duration = initialDuration / 2.0
        }
        
        if tweenOptions.containsRepeat() {
           let cycles = tweenOptions.repeatCount() + 1
            duration = initialDuration / Double(cycles)
        }
    }
    
    //Declared in protocol Tweenable
    //Since this method can be overriden it's implemented with in the class instead of the extension
    //Declarations from extensions cannot be overridden yet
    public func kill() {
        unregisterLoop()
        
        print("kill: \(id)")
    }
    
    
    
    public func update(value: (progress: Double) -> Void) -> Self {
        updateProgress = value
        
        return self
    }
    
    public func updateTotal(value: (progressTotal: Double) -> Void) -> Self {
        updateProgressTotal = value
        
        return self
    }
    
    public func complete(value: () -> Void) -> Self {
        complete = value
        
        return self
    }
    
    public func repeatCycleChange(value: (repeatCycle: Int) -> Void) -> Self {
        repeatCycleChange = value
        
        return self
    }
    
    
    public func memoryReference(value: TweenMemoryReference) -> Self {
        memoryReference = value
        
        return self
    }
    
    
    public func options(values: TweenOptions ...) -> Self {
        tweenOptions = values
        
        initialRepeatCount = tweenOptions.repeatCount()
        currentRepeatCycle = tweenOptions.repeatCount()
        
        return self
    }
}


extension UTweenBase: WeaklyLoopable {
    func loopWeakly() {
        loop()
    }
}



extension UTweenBase: Tweenable {
    public func start() -> Self {
        guard !isPlaying else {
            print("tween: \(id) already playing")
            return self
        }
        
        print("start: \(id) with direction: \(direction)")
        switch direction {
        case .Forward:
            progress = 0.0
            progressTotal = 0.0
            break
        case .Reverse:
            progress = 1.0
            progressTotal = 1.0
            break
        }
        
        computeConfigs()
        
        unregisterLoop()
        registerLoop()
        
        return self
    }
    
    public func stop() {
        print("stop: \(id)")
        unregisterLoop()
        
        switch direction {
        case .Forward:
            progress = 1.0
            progressTotal = 1.0
            break
        case .Reverse:
            progress = 0.0
            progressTotal = 0.0
            break
        }
    }
    
    public func pause() {
        print("pause: \(id)")
        unregisterLoop()
    }
    
    public func resume() {
        print("resume: \(id)")
        registerLoop()
    }
    
    public func tweenDirection(direction: TweenDirection) -> Self {
        self.direction = direction
        
        return self
    }
}
