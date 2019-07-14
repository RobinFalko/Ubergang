//
//  Ease.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public enum Ease {
    case linear
    case back(_ type: EaseType)
    case bounce(_ type: EaseType)
    case circ(_ type: EaseType)
    case cubic(_ type: EaseType)
    case elastic(_ type: EaseType)
    case expo(_ type: EaseType)
    case quad(_ type: EaseType)
    case quart(_ type: EaseType)
    case quint(_ type: EaseType)
    case sine(_ type: EaseType)
    
    var function: (_ t: Double, _ b: Double, _ c: Double, _ d: Double) -> Double {
        switch self {
        case .linear: return Linear.ease
        case let .back(type): return type.function(for: Back.self)
        case let .bounce(type): return type.function(for: Bounce.self)
        case let .circ(type): return type.function(for: Circ.self)
        case let .cubic(type): return type.function(for: Cubic.self)
        case let .elastic(type): return type.function(for: Elastic.self)
        case let .expo(type): return type.function(for: Expo.self)
        case let .quad(type): return type.function(for: Quad.self)
        case let .quart(type): return type.function(for: Quart.self)
        case let .quint(type): return type.function(for: Quint.self)
        case let .sine(type): return type.function(for: Sine.self)
        }
    }
    
    var opposite: Ease {
        switch self {
        case .linear: return self
        case let .back(type): return .back(type.opposite())
        case let .bounce(type): return .bounce(type.opposite())
        case let .circ(type): return .circ(type.opposite())
        case let .cubic(type): return .cubic(type.opposite())
        case let .elastic(type): return .elastic(type.opposite())
        case let .expo(type): return .expo(type.opposite())
        case let .quad(type): return .quad(type.opposite())
        case let .quart(type): return .quart(type.opposite())
        case let .quint(type): return .quint(type.opposite())
        case let .sine(type): return .sine(type.opposite())
        }
    }
}

public enum EaseType {
    case `in`, out, inOut
    
    internal func function(for easing: CurveEasing.Type) -> (_ t: Double, _ b: Double, _ c: Double, _ d: Double) -> Double {
        switch self {
        case .in: return easing.easeIn
        case .out: return easing.easeOut
        case .inOut: return easing.easeInOut
        }
    }
    
    internal func opposite() -> EaseType {
        switch self {
        case .in: return .out
        case .out: return .in
        case .inOut: return self
        }
    }
}

public protocol CurveEasing {
    static func easeIn(t: Double, b: Double, c: Double, d: Double) -> Double
    static func easeOut(t: Double, b: Double, c: Double, d: Double) -> Double
    static func easeInOut(t: Double, b: Double, c: Double, d: Double) -> Double
}

open class Easing {}
