//
//  UTimeline.swift
//  Ubergang
//
//  Created by RF on 05/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public class UTimeline<T>: UTween<T> {
    var tweens: [Tweenable] = []
    var startTimeForTweenId: [String : Double] = [:]
    
    public override init(id: String) {
        super.init(id: id)
    }
    
    public func append(tween: Tweenable) {
        tween.
        tweens.append(tween)
        
        startTimeForTweenId[tween.id] = duration
        
        duration += tween.duration
        
        durationTotal = duration
    }
    
    public func insert(tween: Tweenable, at time: Double) {
        tweens.append(tween)
        
        startTimeForTweenId[tween.id] = time
        
        for tween in tweens {
            duration = max(duration, time + tween.duration)
        }
        
        durationTotal = duration
    }
    
    override public var progress: Double {
        set {
            time = newValue * duration
            
            for var tween in tweens {
                let startTime = startTimeForTweenId[tween.id]!
                
                let mapped = mapValueInRange(time,
                                             fromLow: startTime, fromHigh: duration + startTime,
                                             toLow: 0.0, toHigh: duration / tween.duration )
                
                tween.progress = clamp(mapped, lower: 0.0, upper: 1.0)
            }
        }
        get {
            return time / duration
        }
    }
    
    func mapValueInRange(value: Double, fromLow: Double, fromHigh: Double, toLow: Double, toHigh: Double) -> Double {
        let fromRangeSize = fromHigh - fromLow
        let toRangeSize = toHigh - toLow
        let valueScale = (value - fromLow) / fromRangeSize
        return toLow + (valueScale * toRangeSize)
    }
    
    func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
        return max(lower, min(value, upper))
    }
}