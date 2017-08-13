//
//  TweenOptions.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 20/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public func ==(a: TweenOptions, b: TweenOptions) -> Bool {
    switch (a, b) {
    case (.yoyo, .yoyo): return true
    case (.repeat(let l), .repeat(let r)) where l == r: return true
    default: return false
    }
}

internal extension Sequence where Iterator.Element == TweenOptions {
    func repeatCount() -> Int {
        var repeatCount = 0
        self.forEach {
            if case .repeat(let count) = $0 {
                repeatCount = count
            }
        }
        
        return repeatCount
    }
    
    func containsRepeat() -> Bool {
        return repeatCount() > 0
    }
    
    func containsYoyo() -> Bool {
        return self.contains(.yoyo)
    }
}

public enum TweenOptions: Equatable {
    case yoyo
    case `repeat`(Int)
}
