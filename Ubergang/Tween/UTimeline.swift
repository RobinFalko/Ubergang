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
     Initialize a `UTimeline` with a random id.
     
     Tweens all containing elements from start to end.
     */
    public convenience init() {
        let id = "\(#file)_\(arc4random())_update"
        self.init(id: id)
    }
    
    /**
     Initialize a `UTimeline`.
     
     Tweens all containing elements from start to end.
     
     - Parameter id: The unique id of the Tween
     */
    public override init(id: String) {
        super.init(id: id)
        
        initialDuration = 0
        duration = 0
        durationTotal = 0
    }
    
    override func computeConfigs() {
        super.computeConfigs()
        
        for tween in tweens {
            switch direction {
            case .forward: tween.currentEase = tween.ease
            case .reverse: tween.currentEase = tween.ease
            case .backward: tween.currentEase = tween.ease.opposite
            }
        }
    }
    
    open func append(_ tween: UTweenBase) {
//        tween.computeConfigs()
//
//        tweens.append(tween)
//
//        startTimeForTweenId[tween.id] = initialDuration
//
//        initialDuration += tween.durationTotal
//
//        computeConfigs()
        
        insert(tween, at: durationTotal)
    }
    
    open func insert(_ tween: UTweenBase, at time: Double) {
        tween.computeConfigs()
        
        tweens.append(tween)
        
        startTimeForTweenId[tween.id] = time
        duration = max(duration, time + tween.durationTotal)
        initialDuration = duration
        
        tweens.sort(by: {
            startTimeForTweenId[$0.id] ?? 0 < startTimeForTweenId[$1.id] ?? 0
        })
        computeConfigs()
    }
    
    override open var progress: Double {
        set {
            time = newValue * duration
            
            for tween in tweens.enumerated() {
                let repeatCount = tweenOptions.repeatCount()    
                var cycles = Double(repeatCount + 1)
                
                if tweenOptions.contains(.yoyo) && !tweenOptions.containsRepeat() {
                    cycles *= 2.0
                }
                
                var startTime = startTimeForTweenId[tween.id]! / cycles
                
                if direction == .backward {
                    startTime = durationTotal - tween.durationTotal - startTime
                }
                
                let mapped = Math.mapValueInRange(time,
                                             fromLower: startTime, fromUpper: startTime + tween.durationTotal / cycles,
                                             toLower: 0.0, toUpper: 1.0)
                
                let value = tween.direction == .forward ? mapped : 1 - mapped
                
                let clamped = Math.clamp(value, lower: 0.0, upper: 1.0)
                tween.progressTotal = clamped
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
