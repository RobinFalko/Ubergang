//
//  UTweenBase.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 10/04/16.
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
    
    /**
     Get or set the total progress of the Tween or Timeline.
     
     The total progress will take any tween options into account.
     */
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
        XCGLogger.debug("deinit tween: \(id)")
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
    
    /**
     Kills the Tween or Timeline.
     */
    //Declared in protocol Tweenable
    //Since this method can be overriden it's implemented with in the class instead of the extension
    //Declarations from extensions cannot be overridden yet
    public func kill() {
        unregisterLoop()
        
        XCGLogger.verbose("kill: \(id)")
    }
    
    /**
     Set the closure for updating the progress of the Tween or Timeline.
     
     - Parameter value: The closure to be called on update
     - Returns: The current Tween or Timeline
     */
    public func update(value: (progress: Double) -> Void) -> Self {
        updateProgress = value
        
        return self
    }
    
    /**
     Set the closure for updating the total progress of the Tween or Timeline.
     
     - Parameter value: The closure to be called on update
     - Returns: The current Tween or Timeline
     */
    public func updateTotal(value: (progressTotal: Double) -> Void) -> Self {
        updateProgressTotal = value
        
        return self
    }
    
    /**
     Set the closure for completing the Tween or Timeline.
     
     - Parameter value: The closure to be called on complete
     - Returns: The current Tween or Timeline
     */
    public func complete(value: () -> Void) -> Self {
        complete = value
        
        return self
    }
    
    
    /**
     Set the closure for changing the repeat cycle of the Tween or Timeline.
     
     This event only occures if the tween option `Repeat` is set.
     
     - Parameter value: The closure to be called on changing the repeat cycle
     - Returns: The current Tween or Timeline
     */
    public func repeatCycleChange(value: (repeatCycle: Int) -> Void) -> Self {
        repeatCycleChange = value
        
        return self
    }
    
    /**
     Set the memory reference type of the Tween or Timeline.
     
     memoryReference determines how to handle the reference count for the tween. Ubergang will increase the reference count if the option is set to .Strong or won’t increase it if it’s set to .Weak. 
     
     These two rules are valid for most cases:
     - The Tween or Timeline is not stored in a field variable, use .Strong
     - The Tween or Timeline is stored in a field variable, use .Weak
     
     - Parameter value: The memory reference type
     - Returns: The current Tween or Timeline
     */
    public func memoryReference(value: TweenMemoryReference) -> Self {
        memoryReference = value
        
        return self
    }
    
    /**
     Set the `TweenOptions` for the Tween or Timeline.
     
     Using options you can let the Tween repeat n (Int) times, let it yoyo or combine both options.
     
     - Parameter value: All options seperated by ',' to be applied
     - Returns: The current Tween or Timeline
     */
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
    
    /**
     Start the Tween or Timeline.
     
     `Start` will reset the total progress when invoked - That means it will set the total progress to 0.0 in forward direction or to 1.0 in reverse direction. Starts a Tween only if it's not playing.
     
     - Returns: The current Tween or Timeline
     */
    public func start() -> Self {
        guard !isPlaying else {
            XCGLogger.info("tween: \(id) already playing")
            return self
        }
        
        XCGLogger.debug("start: \(id) with direction: \(direction)")
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
    
    /**
     Stop the Tween or Timeline.
     
     `Stop` will set the total progress when invoked - That means it will set the total progress to 1.0 in forward direction or to 0.0 in reverse direction.
     */
    public func stop() {
        XCGLogger.debug("stop: \(id)")
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
    
    /**
     Pause the Tween or Timeline.
     */
    public func pause() {
        XCGLogger.debug("pause: \(id)")
        unregisterLoop()
    }
    
    /**
     Resume the Tween or Timeline.
     */
    public func resume() {
        XCGLogger.debug("resume: \(id)")
        registerLoop()
    }
    
    /**
     Change the direction of the Tween or Timeline.
     
     - Parameter direction: The play direction of the Tween or Timeline
     - Returns: The current Tween or Timeline
     */
    public func tweenDirection(direction: TweenDirection) -> Self {
        self.direction = direction
        
        return self
    }
}
