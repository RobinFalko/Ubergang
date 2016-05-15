//
//  TweenOptions.swift
//  Tween
//
//  Created by RF on 20/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public func ==(a: TweenOptions, b: TweenOptions) -> Bool {
    switch (a, b) {
    case (.Yoyo, .Yoyo): return true
    case (.Repeat(let l), .Repeat(let r)) where l == r: return true
    default: return false
    }
}

internal extension SequenceType where Generator.Element == TweenOptions {
    func repeatCount() -> Int {
        var repeatCount = 0
        self.forEach {
            if case .Repeat(let count) = $0 {
                repeatCount = count
            }
        }
        
        return repeatCount
    }
    
    func containsRepeat() -> Bool {
        return repeatCount() > 0
    }
    
    func containsYoyo() -> Bool {
        return self.contains(.Yoyo)
    }
}

public enum TweenOptions: Equatable {
    case Yoyo
    case Repeat(Int)
}