//
//  Bezier.swift
//  Ubergang
//
//  Created by RF on 17/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import GLKit

class Bezier {
    static func linear(t _t: CGFloat, p0: CGPoint, p1: CGPoint) -> CGPoint {
        
        let v0 = GLKVector2(v: (Float(p0.x), Float(p0.y)))
        let v1 = GLKVector2(v: (Float(p1.x), Float(p1.y)))
        
        let t = Float(_t)
        
        let v0r = GLKVector2MultiplyScalar(v0, 1-t)
        let v1r = GLKVector2MultiplyScalar(v1, t)
        
        let vResult = GLKVector2Add(v0r, v1r)
        
        return CGPoint(x: CGFloat(vResult.x), y: CGFloat(vResult.y))
    }
    
    static func quad(t _t: CGFloat, p0: CGPoint, p1: CGPoint, p2: CGPoint) -> CGPoint {
        
        let v0 = GLKVector2(v: (Float(p0.x), Float(p0.y)))
        let v1 = GLKVector2(v: (Float(p1.x), Float(p1.y)))
        let v2 = GLKVector2(v: (Float(p2.x), Float(p2.y)))
        
        let t = Float(_t)
        
        let v0r = GLKVector2MultiplyScalar(v0, pow(1-t, 2))
        let v1r = GLKVector2MultiplyScalar(v1, 2*t*(1-t))
        let v2r = GLKVector2MultiplyScalar(v2, t*t)
        
        var vResult = GLKVector2Add(v0r, v1r)
        vResult = GLKVector2Add(vResult, v2r)
        
        return CGPoint(x: CGFloat(vResult.x), y: CGFloat(vResult.y))
    }
    
    static func cubic(t _t: CGFloat, p0: CGPoint, p1: CGPoint, p2: CGPoint, p3: CGPoint) -> CGPoint {
        let v0 = GLKVector2(v: (Float(p0.x), Float(p0.y)))
        let v1 = GLKVector2(v: (Float(p1.x), Float(p1.y)))
        let v2 = GLKVector2(v: (Float(p2.x), Float(p2.y)))
        let v3 = GLKVector2(v: (Float(p3.x), Float(p3.y)))
        
        let t = Float(_t)
        
        let v0r = GLKVector2MultiplyScalar(v0, pow(1-t, 3))
        let v1r = GLKVector2MultiplyScalar(v1, 3 * t * pow(1-t, 2))
        let v2r = GLKVector2MultiplyScalar(v2, 3 * pow(t, 2) * (1-t))
        let v3r = GLKVector2MultiplyScalar(v3, pow(t, 3))
        
        var vResult = GLKVector2Add(v0r, v1r)
        vResult = GLKVector2Add(vResult, v2r)
        vResult = GLKVector2Add(vResult, v3r)
        
        return CGPoint(x: CGFloat(vResult.x), y: CGFloat(vResult.y))
    }
}