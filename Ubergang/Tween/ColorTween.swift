//
//  ColorTween.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

open class ColorTween: UTween<UIColor> {
    
    public convenience init() {
        let id = "\(#file)_\(arc4random())_update"
        self.init(id: id)
    }
    
    public override init(id: String) {
        super.init(id: id)
    }
    
    override func compute(_ value: Double) -> UIColor {
        _ = super.compute(value)
        
        let from = self.from()
        let to = self.to()
        
        var rFrom: CGFloat = 0
        var gFrom: CGFloat = 0
        var bFrom: CGFloat = 0
        var aFrom: CGFloat = 0
        
        var rTo: CGFloat = 0
        var gTo: CGFloat = 0
        var bTo: CGFloat = 0
        var aTo: CGFloat = 0
        
        from.getRed(&rFrom, green: &gFrom, blue: &bFrom, alpha: &aFrom)
        to.getRed(&rTo, green: &gTo, blue: &bTo, alpha: &aTo)
        
        let r = rFrom + (rTo - rFrom) * CGFloat(value)
        let g = gFrom + (gTo - gFrom) * CGFloat(value)
        let b = bFrom + (bTo - bFrom) * CGFloat(value)
        let a = aFrom + (aTo - aFrom) * CGFloat(value)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
