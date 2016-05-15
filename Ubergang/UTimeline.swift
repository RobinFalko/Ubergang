//
//  UTimeline.swift
//  Ubergang
//
//  Created by RF on 05/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class UTimeline: UTweenBase {
    var tweens: [UTweenBase] = []
    var startTimeForTweenId: [String : Double] = [:]
    
    public override init(id: String) {
        super.init(id: id)
    }
    
    public func append(tween: UTweenBase) {
        tween.computeConfigs()
        
        tweens.append(tween)
        
        startTimeForTweenId[tween.id] = initialDuration
        
        initialDuration += tween.durationTotal
        
        computeConfigs()
    }
    
    public func insert(tween: UTweenBase, at time: Double) {
        tween.computeConfigs()
        
        tweens.append(tween)
        
        startTimeForTweenId[tween.id] = time
        
        for tween in tweens {
            duration = max(duration, time + tween.durationTotal)
        }
        
        initialDuration = duration
        
        computeConfigs()
    }
    
    override public var progress: Double {
        set {
            time = newValue * duration
            
            for tween in tweens {
                
                let repeatCount = tweenOptions.repeatCount()
                var cycles = Double(repeatCount + 1)
                
                if tweenOptions.contains(.Yoyo) && !tweenOptions.containsRepeat() {
                    cycles *= 2.0
                }
                
                let startTime = startTimeForTweenId[tween.id]! / cycles
                
                let mapped = mapValueInRange(time,
                                             fromLower: startTime, fromUpper: startTime + tween.durationTotal / cycles,
                                             toLower: 0.0, toUpper: 1.0)
                
                tween.progressTotal = clamp(mapped, lower: 0.0, upper: 1.0)
            }
            
            super.progress = newValue
        }
        get {
            return time / duration
        }
    }
    
    func mapValueInRange(value: Double, fromLower: Double, fromUpper: Double, toLower: Double, toUpper: Double) -> Double {
        let fromRangeSize = fromUpper - fromLower
        let toRangeSize = toUpper - toLower
        let valueScale = (value - fromLower) / fromRangeSize
        return toLower + (valueScale * toRangeSize)
    }
    
    func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
        return max(lower, min(value, upper))
    }
    
    override public func memoryReference(value: TweenMemoryReference) -> Self {
        memoryReference = value
        
        return self
    }
}