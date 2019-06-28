//
//  Tween.swift
//  Ubergang
//
//  Created by RF on 06.08.17.
//  Copyright © 2017 Robin Falko. All rights reserved.
//

// Not sure why this won't work.
// Use repetitive code in extensions instead
//public protocol GenericTweenable {
//    associatedtype TweenType: UTween<Self>
//    func tween(to: Self) -> TweenType
//}
//
//public extension GenericTweenable {
//    func tween(to: Self) -> TweenType {
//        return TweenType().tween(from: self, to: to)
//    }
//}
//extension CGPoint: GenericTweenable {typealias TweenType = CGPointTween}
//extension UIColor: GenericTweenable {typealias TweenType = ColorTween}
//extension CGAffineTransform: Generic     Tweenable {typealias TweenType = TransformTween}

public extension CGPoint {
    func tween(to: CGPoint) -> CGPointTween {
        return CGPointTween().from(self, to: to)
    }
}

public extension UIColor {
    func tween(to: UIColor) -> ColorTween {
        return ColorTween().from(self, to: to)
    }
}

public extension CGAffineTransform {
    func tween(to: CGAffineTransform) -> TransformTween {
        return TransformTween().from(self, to: to)
    }
}

public protocol NumericTweenable: Numeric {
    func tween(to: Self) -> NumericTween<Self>
}

public extension NumericTweenable {
    func tween(to: Self) -> NumericTween<Self> {
        return NumericTween<Self>().from(self, to: to)
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
