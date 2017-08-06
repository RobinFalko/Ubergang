//
//  UTimeline.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 05/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class UTimeline: UTweenBase {
    var tweens: [UTweenBase] = []
    var startTimeForTweenId: [String : Double] = [:]
    
    open var count: Int { return tweens.count }
    
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
    
    open func append(_ tween: UTweenBase) {
        tween.computeConfigs()
        
        tweens.append(tween)
        
        startTimeForTweenId[tween.id] = initialDuration
        
        initialDuration += tween.durationTotal
        
        computeConfigs()
    }
    
    open func insert(_ tween: UTweenBase, at time: Double) {
        tween.computeConfigs()
        
        tweens.append(tween)
        
        startTimeForTweenId[tween.id] = time
        
        for tween in tweens {
            duration = max(duration, time + tween.durationTotal)
        }
        
        initialDuration = duration
        
        computeConfigs()
    }
    
    override open var progress: Double {
        set {
            time = newValue * duration
            
            for tween in tweens {
                
                let repeatCount = tweenOptions.repeatCount()    
                var cycles = Double(repeatCount + 1)
                
                if tweenOptions.contains(.yoyo) && !tweenOptions.containsRepeat() {
                    cycles *= 2.0
                }
                
                let startTime = startTimeForTweenId[tween.id]! / cycles
                
                let mapped = Math.mapValueInRange(time,
                                             fromLower: startTime, fromUpper: startTime + tween.durationTotal / cycles,
                                             toLower: 0.0, toUpper: 1.0)
                
                let value = tween.direction == .forward ? mapped : 1 - mapped
                
                tween.progressTotal = Math.clamp(value, lower: 0.0, upper: 1.0)
            }
            
            super.progress = newValue
        }
        get {
            return time / duration
        }
    }
    
    
    @discardableResult
    override open func reference(_ value: TweenMemoryReference) -> Self {
        reference = value
        
        return self
    }
}
