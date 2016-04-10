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
        
        startTimeForTweenId[tween.id] = duration
        
        duration += tween.duration
        
        computeConfigs()
    }
    
    public func insert(tween: UTweenBase, at time: Double) {
        tween.computeConfigs()
        tweens.append(tween)
        
        startTimeForTweenId[tween.id] = time
        
        for tween in tweens {
            duration = max(duration, time + tween.duration)
        }
        
        computeConfigs()
    }
    
    override public var progress: Double {
        set {
            time = newValue * duration
            timeTotal = newValue * durationTotal
            
            for tween in tweens {
                let startTime = startTimeForTweenId[tween.id]!
                
                let mapped = mapValueInRange(time,
                                             fromLower: startTime, fromUpper: duration + startTime,
                                             toLower: 0.0, toUpper: duration / tween.duration )
                
//                if mapped > 1.0 && mapped < Double(currentRepeatCount + 1) {
//                    mapped = mapped - floor(mapped)
//                }
                
                tween.progress = clamp(mapped, lower: 0.0, upper: 1.0)
                
                //implement repeat count somehow
            }
            
            super.progress = newValue
        }
        get {
            return timeTotal / durationTotal
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