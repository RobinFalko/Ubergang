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
    let degToRad = M_PI / 180.0
    
    var numericTween: NumericTween<CGFloat>!
    
    override var selected: Bool {
        get {
            return super.selected
        }
        set {
            if newValue {
                numericTween.tweenDirection(.Forward).start()
            } else {
                numericTween.tweenDirection(.Reverse).start()
            }
            super.selected = newValue
        }
    }
    
    
    override func setupTween() {
        super.setupTween()
        
        numericTween = UTweenBuilder
            .to( CGFloat(180.0 * degToRad),
                 current: 0.0,
                 update: { [unowned self] value in
                    self.imageView!.layer.transform = CATransform3DRotate(CATransform3DIdentity, value, 0.0, 1.0, 0.0)
                },
                 duration: 0.5,
                 id: "transform_\(rand())")
        
        numericTween.ease(Cubic.easeInOut)
        numericTween.memoryReference(.Weak)
    }
}
