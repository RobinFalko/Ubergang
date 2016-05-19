//
//  CGPath.swift
//  Ubergang
//
//  Created by RF on 19/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

extension CGPath {
    func forEach(@noescape body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        func callback(info: UnsafeMutablePointer<Void>, element: UnsafePointer<CGPathElement>) {
            let body = unsafeBitCast(info, Body.self)
            body(element.memory)
        }
        let unsafeBody = unsafeBitCast(body, UnsafeMutablePointer<Void>.self)
        CGPathApply(self, unsafeBody, callback)
    }
    
    func getElements() -> [(type: CGPathElementType, points: [CGPoint])] {
        var result = [(type: CGPathElementType, points: [CGPoint])]()
        var elementType: CGPathElementType!
        var points: [CGPoint]!
        var previousLastPoint: CGPoint!
        forEach { element in
            switch (element.type) {
            case CGPathElementType.MoveToPoint:
                previousLastPoint = element.points[0]
            case .AddLineToPoint:
                points = [CGPoint]()
                elementType = element.type
                points.append(previousLastPoint)
                points.append(element.points[0])
                result.append((elementType, points))
                
                previousLastPoint = element.points[0]
            case .AddQuadCurveToPoint:
                points = [CGPoint]()
                elementType = element.type
                points.append(previousLastPoint)
                points.append(element.points[0])
                points.append(element.points[1])
                result.append((elementType, points))
                
                previousLastPoint = element.points[1]
            case .AddCurveToPoint:
                points = [CGPoint]()
                elementType = element.type
                points.append(previousLastPoint)
                points.append(element.points[0])
                points.append(element.points[1])
                points.append(element.points[2])
                result.append((elementType, points))
                
                previousLastPoint = element.points[2]
            case .CloseSubpath:
                elementType = element.type
                points.append(previousLastPoint)
                result.append((elementType, points))
            }
        }
        
        return result
    }
    
    func getElement(index: Int) -> (type: CGPathElementType, points: [CGPoint])? {
        let elements = getElements()
        if index >= elements.count {
            return nil
        }
        return elements[index]
    }
    
    func elementCount() -> Int {
        var count = 0
        self.forEach { element in
            if element.type != .MoveToPoint && element.type != .CloseSubpath {
                count += 1
            }
        }
        return count
    }
}
