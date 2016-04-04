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

public enum TweenOptions: Equatable {
    case Yoyo
    case Repeat(Int)
}