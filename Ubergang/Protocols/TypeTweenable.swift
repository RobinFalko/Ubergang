//
//  Tween.swift
//  Ubergang
//
//  Created by RF on 06.08.17.
//  Copyright © 2017 Robin Falko. All rights reserved.
//

public protocol NumericTweenable: Numeric {
    func tween(to: Self) -> NumericTween<Self>
}

public extension NumericTweenable {
    func tween(to: Self) -> NumericTween<Self> {
        return NumericTween().from(self, to: to)
    }
}

extension Double : NumericTweenable {}
extension Float  : NumericTweenable {}
extension Int    : NumericTweenable {}
extension Int8   : NumericTweenable {}
extension Int16  : NumericTweenable {}
extension Int32  : NumericTweenable {}
extension Int64  : NumericTweenable {}
extension UInt   : NumericTweenable {}
extension UInt8  : NumericTweenable {}
extension UInt16 : NumericTweenable {}
extension UInt32 : NumericTweenable {}
extension UInt64 : NumericTweenable {}
extension CGFloat: NumericTweenable {}
