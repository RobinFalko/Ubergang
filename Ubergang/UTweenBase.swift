//
//  UTweenBase.swift
//  Ubergang
//
//  Created by RF on 10/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public class UTweenBase {
    private let _id: String
    
    public var id: String {
        return _id
    }
    
    var updateProgress: ((progress: Double) -> Void)?
    var complete: (() -> Void)?
    
    var tweenOptions: [TweenOptions]!
    
    public var duration = 0.0
    var durationTotal = 0.0
    
    var ease: Easing = Ease.linear
    var easeValue = 0.0
    
    var absolute = false
    
    var time = 0.0
    var timeTotal = 0.0
    
    var memoryReference: TweenMemoryReference = .Strong
    
    var direction: TweenDirection = .Forward
    var initialRepeatCount: Int = 0
    var currentRepeatCount: Int {
        for tweenOption in tweenOptions {
            switch tweenOption {
            case .Repeat(let count):
                return count
            default:
                break
            }
        }
        return initialRepeatCount
    }
    
    public var segmentProgress: Double {
        get { return 0.0 }
        set {
        }
    }
    
    public var progress: Double {
        get { return 0.0 }
        set {
            updateProgress?( progress: newValue )
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
        
        //TODO: should this be duration or rather durationTotal?
        progress += Timer.delta / duration * Double(direction == .Forward ? 1 : -1)
        
        checkForStop()
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
                    progress = 0
                    return true
                }
            default:
                return false
            }
        }
        
        return false
    }
    
    func computeConfigs() {
        for value in tweenOptions {
            
            switch value {
            case .Yoyo:
                //compute duration
                durationTotal = duration * 0.5
                break
            case .Repeat(let previousCount):
                let count = initialRepeatCount
                print("start: count \(initialRepeatCount)")
                
                //reset repeat count
                let index = tweenOptions.indexOf(.Repeat(previousCount))
                tweenOptions.removeAtIndex(index!)
                tweenOptions.insert(.Repeat(count), atIndex: index!)
                
                //compute duration
                let durationMultiplier = count == Int.max ? Int.max : count + 1
                durationTotal = duration * Double(durationMultiplier)
                
                print("start: durationTotal \(durationTotal)")
                break
            }
        }
    }
    
    //Declared in protocol Tweenable
    //Since this method can be overriden it's implemented with in the class instead of the extension
    // Declarations from extensions cannot be overridden yet
    public func kill() {
        unregisterLoop()
        
        print("destroy: \(id)")
    }
    
    
    
    public func update(value: (progress: Double) -> Void) -> Self {
        updateProgress = value
        
        return self
    }
    
    public func complete(value: () -> Void) -> Self {
        complete = value
        
        return self
    }
    
    
    public func memoryReference(value: TweenMemoryReference) -> Self {
        memoryReference = value
        
        return self
    }
    
    
    public func options(values: TweenOptions ...) -> Self {
        tweenOptions = values
        
        initialRepeatCount = currentRepeatCount
        
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
        switch direction {
        case .Forward:
            progress = 0.0
            break
        case .Reverse:
            progress = 1.0
            break
        }
        
        computeConfigs()
        
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
