//
//  TweenControlButton.swift
//  TweenApp
//
//  Created by RF on 16/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class TweenControlButton: UIButton {
    var timeline: UTimeline!
    
    var tintNormal: UIColor!
    var tintSelected: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTarget(self, action: #selector(touchDown), forControlEvents: .TouchDown)
        addTarget(self, action: #selector(touchUp), forControlEvents: .TouchDragExit)
        addTarget(self, action: #selector(touchUp), forControlEvents: .TouchUpInside)
        
        
        var image = imageForState(.Normal)?.imageWithRenderingMode(.AlwaysTemplate)
        setImage(image, forState: .Normal)
        
        image = imageForState(.Selected)?.imageWithRenderingMode(.AlwaysTemplate)
        setImage(image, forState: .Selected)
        
        tintColor = tintNormal
        
        setupTween()
    }
    
    override var selected: Bool {
        get {
            return super.selected
        }
        set {
            tintColor = !newValue ? tintNormal : tintSelected
            super.selected = newValue
        }
    }
    
    
    func setupTween() {
        let tween = UTweenBuilder
            .to( 0.5,
                 current: { 1.0 },
                 update: { [unowned self] (value) in
                    self.alpha = value
                 },
                 duration: 0.2,
                 id: "alpha_\(rand())")
        tween.ease(Cubic.easeOut)
        
        let transform = CGAffineTransformMakeScale(0.9, 0.9)
        let transformTween = UTweenBuilder
            .to( transform,
                 current: { CGAffineTransformIdentity },
                 update: { [unowned self] value in
                    self.transform = value
                },
                 duration: 0.2,
                 id: "transform_\(rand())")
        
        transformTween.ease(Cubic.easeOut)
        
        timeline = UTimeline(id: "timeline_\(rand())")
        timeline.memoryReference(.Weak)
        timeline.insert(tween, at: 0)
        timeline.insert(transformTween, at: 0)
    }
    
    func touchDown() {
        timeline.tweenDirection(.Forward).start()
        
        tweenOutline()
    }
    
    func touchUp() {
        timeline.tweenDirection(.Reverse).start()
    }
    
    func tweenOutline() {
        let imageView = UIImageView(image: UIImage(named: "CircleOutline")!.imageWithRenderingMode(.AlwaysTemplate))
        imageView.tintColor = tintColor
        imageView.frame = frame
        superview!.addSubview(imageView)
        
        let transform = CGAffineTransformMakeScale(1.3, 1.3)
        let transformTween = UTweenBuilder
            .to( transform,
                 current: { CGAffineTransformMakeScale(1.0, 1.0) },
                 update: { (value, progress) in
                    imageView.alpha = 1 - CGFloat(progress)
                    imageView.transform = value
                },
                 duration: 0.5,
                 id: "outline_\(rand())")
        
        transformTween.ease(Cubic.easeOut)
        transformTween.complete {
            imageView.removeFromSuperview()
        }
        transformTween.start()
    }
}
