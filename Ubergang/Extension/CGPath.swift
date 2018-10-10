//
//  CGPath.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 19/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

extension CGPath {
    func forEach(_ body: @escaping @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        func callback(_ info: UnsafeMutableRawPointer, element: UnsafePointer<CGPathElement>) {
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: callback as! CGPathApplierFunction)
    }
    
    func getElements() -> [(type: CGPathElementType, points: [CGPoint])] {
        var result = [(type: CGPathElementType, points: [CGPoint])]()
        var elementType: CGPathElementType!
        var points: [CGPoint]!
        var firstPoint: CGPoint!
        var previousLastPoint: CGPoint!
        forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                firstPoint = element.points[0]
                previousLastPoint = firstPoint
            case .addLineToPoint:
                points = [CGPoint]()
                elementType = element.type
                points.append(previousLastPoint)
                points.append(element.points[0])
                result.append((elementType, points))
                
                previousLastPoint = element.points[0]
            case .addQuadCurveToPoint:
                points = [CGPoint]()
                elementType = element.type
                points.append(previousLastPoint)
                points.append(element.points[0])
                points.append(element.points[1])
                result.append((elementType, points))
                
                previousLastPoint = element.points[1]
            case .addCurveToPoint:
                points = [CGPoint]()
                elementType = element.type
                points.append(previousLastPoint)
                points.append(element.points[0])
                points.append(element.points[1])
                points.append(element.points[2])
                result.append((elementType, points))
                
                previousLastPoint = element.points[2]
            case .closeSubpath:
                points = [CGPoint]()
                elementType = element.type
                points.append(previousLastPoint)
                points.append(firstPoint)
                result.append((elementType, points))
            }
        }
        
        return result
    }
    
    func getElement(_ index: Int) -> (type: CGPathElementType, points: [CGPoint])? {
        let elements = getElements()
        if index >= elements.count {
            return nil
        }
        return elements[index]
    }
    
    func elementCount() -> Int {
        var count = 0
        self.forEach { element in
            if element.type != .moveToPoint && element.type != .closeSubpath {
                count += 1
            }
        }
        return count
    }
}
