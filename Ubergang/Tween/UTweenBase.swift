//
//  UTweenBase.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 10/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class UTweenBase {
    fileprivate lazy var logger = UTweenSetup.instance.logger
    
    private(set) open var id: String
    
    var updateProgress: ((_ progress: Double) -> Void)?
    var updateProgressTotal: ((_ progressTotal: Double) -> Void)?
    var complete: (() -> Void)?
    var repeatCycleChange: ((_ repeatCycle: Int) -> Void)?
    
    var tweenOptions: [TweenOptions]!
    
    var initialDuration: Double = 0.5
    open var duration = 0.5
    var durationTotal = 0.5
    
    var ease: Easing = Linear.ease
    var easeValue = 0.0
    
    var absolute = false
    
    var time = 0.0
    var timeTotal = 0.0
    
    var reference: TweenMemoryReference = .strong
    
    var direction: TweenDirection = .forward
    
    var initialRepeatCount: Int = 0
    var currentRepeatCycle: Int = 0
    
    open var isPlaying: Bool {
        return Engine.instance.contains(id)
    }
    
    open var progress: Double {
        get { return 0.0 }
        set {
            updateProgress?( newValue )
        }
    }
    
    /**
     Get or set the total progress of the Tween or Timeline.
     
     The total progress will take any tween options into account.
     */
    open var progressTotal: Double {
        set {
            
            timeTotal = newValue * durationTotal
            
            let repeatCount = tweenOptions.repeatCount()
            let cycles = Double(repeatCount + 1)
            
            if tweenOptions.contains(.yoyo) {
                let yoyoMultiplier = 2.0 //two ways (forth and back)
                progress = Math.zigZag(newValue * cycles * yoyoMultiplier)
            } else {
                let mod = 1.000001 //slightly above 1.0 to sync progress and progressTotal at 1.0
                progress = fmod(newValue * cycles, mod)
            }
            
            let cycle = Int(newValue * cycles)
            if cycle <= repeatCount && currentRepeatCycle != cycle {
                currentRepeatCycle = cycle
                repeatCycleChange?(cycle)
            }
            
            updateProgressTotal?( newValue )
        }
        get {
            return timeTotal / durationTotal
        }
    }
    
    init(id: String) {
        self.id = id
        
        tweenOptions = [.repeat(initialRepeatCount)]
    }
    
    deinit {
        logger?.verbose("deinit tween: \(id)")
    }
    
    fileprivate func registerLoop() {
        Timer.instance.start()
        
        switch reference {
        case .strong:
            Engine.instance.register(loop, forKey: id)
        case .weak:
            Engine.instance.register(self, forKey: id)
        }
    }
    
    fileprivate func unregisterLoop() {
        Timer.instance.stop()
        
        Engine.instance.unregister(id)
    }
    
    func loop() {
        progressTotal += Timer.delta / durationTotal * Double(direction == .forward ? 1 : -1)
        
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
    open func kill() {
        unregisterLoop()
        
        logger?.verbose("kill: \(id)")
    }
    
    /**
     Set the ID of the Tween or Timeline.
     
     - Parameter value: The ID
     - Returns: The current Tween or Timeline
     */
    @discardableResult
    public func id(_ id: String) -> Self {
        self.id = id
        
        return self
    }
    
    /**
     Set the duration of the Tween or Timeline.
     
     - Parameter value: The duration
     - Returns: The current Tween or Timeline
     */
    @discardableResult
    public func duration(_ value: Double) -> Self {
        initialDuration = value
        duration = value
        durationTotal = value
        
        return self
    }
    
    /**
     Set the closure for updating the progress of the Tween or Timeline.
     
     - Parameter value: The closure to be called on update
     - Returns: The current Tween or Timeline
     */
    open func update(_ value: @escaping (_ progress: Double) -> Void) -> Self {
        updateProgress = value
        
        return self
    }
    
    /**
     Set the closure for updating the total progress of the Tween or Timeline.
     
     - Parameter value: The closure to be called on update
     - Returns: The current Tween or Timeline
     */
    open func updateTotal(_ value: @escaping (_ progressTotal: Double) -> Void) -> Self {
        updateProgressTotal = value
        
        return self
    }
    
    /**
     Set the closure for completing the Tween or Timeline.
     
     - Parameter value: The closure to be called on complete
     - Returns: The current Tween or Timeline
     */
    open func complete(_ value: @escaping () -> Void) -> Self {
        complete = value
        
        return self
    }
    
    
    /**
     Set the closure for changing the repeat cycle of the Tween or Timeline.
     
     This event only occures if the tween option `Repeat` is set.
     
     - Parameter value: The closure to be called on changing the repeat cycle
     - Returns: The current Tween or Timeline
     */
    open func repeatCycleChange(_ value: @escaping (_ repeatCycle: Int) -> Void) -> Self {
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
    open func reference(_ value: TweenMemoryReference) -> Self {
        reference = value
        
        return self
    }
    
    /**
     Set the `TweenOptions` for the Tween or Timeline.
     
     Using options you can let the Tween repeat n (Int) times, let it yoyo or combine both options.
     
     - Parameter value: All options seperated by ',' to be applied
     - Returns: The current Tween or Timeline
     */
    open func options(_ values: TweenOptions ...) -> Self {
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
    @discardableResult
    public func start() -> Self {
        guard !isPlaying else {
            logger?.info("tween: \(id) already playing")
            return self
        }
        
        logger?.info("start: \(id) with direction: \(direction)")
        switch direction {
        case .forward:
            progress = 0.0
            progressTotal = 0.0
            break
        case .reverse:
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
        logger?.info("stop: \(id)")
        unregisterLoop()
        
        switch direction {
        case .forward:
            progress = 1.0
            progressTotal = 1.0
            break
        case .reverse:
            progress = 0.0
            progressTotal = 0.0
            break
        }
    }
    
    /**
     Pause the Tween or Timeline.
     */
    public func pause() {
        logger?.info("pause: \(id)")
        unregisterLoop()
    }
    
    /**
     Resume the Tween or Timeline.
     */
    public func resume() {
        logger?.info("resume: \(id)")
        registerLoop()
    }
    
    /**
     Change the direction of the Tween or Timeline.
     
     - Parameter direction: The play direction of the Tween or Timeline
     - Returns: The current Tween or Timeline
     */
    @discardableResult
    public func direction(_ direction: TweenDirection) -> Self {
        self.direction = direction
        
        return self
    }
}
