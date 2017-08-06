//
//  ReverseButton.swift
//  TweenApp
//
//  Created by RF on 16/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class ReverseButtton: TweenControlButton {
    
    var numericTween: NumericTween<CGFloat>!
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            if newValue {
                _ = numericTween.tweenDirection(.forward).start()
            } else {
                _ = numericTween.tweenDirection(.reverse).start()
            }
            super.isSelected = newValue
        }
    }
    
    
    override func setupTween() {
        super.setupTween()
        
        let degToRad = .pi / 180.0
        
        numericTween = NumericTween(id: "transform_\(arc4random())")
            .from(0, to: CGFloat(180 * degToRad))
            .update { [unowned self] value in
                    self.imageView!.layer.transform = CATransform3DRotate(CATransform3DIdentity, value, 0.0, 1.0, 0.0)
                }
            .duration(0.5)
            .ease(Cubic.easeInOut)
            .reference(.weak)
    }
}
