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
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchDragExit)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        
        
        var image = self.image(for: UIControlState())?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: UIControlState())
        
        image = self.image(for: .selected)?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .selected)
        
        tintColor = tintNormal
        
        setupTween()
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            tintColor = !newValue ? tintNormal : tintSelected
            super.isSelected = newValue
        }
    }
    
    
    func setupTween() {
        let tween = UTweenBuilder
            .to( 0.5,
                 from: 1.0,
                 update: { [unowned self] (value) in
                    self.alpha = value
                 },
                 duration: 0.2,
                 id: "alpha_\(arc4random())")
        _ = tween.ease(Cubic.easeOut)
        
        let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        let transformTween = UTweenBuilder
            .to( transform,
                 from: CGAffineTransform.identity,
                 update: { [unowned self] value in
                    self.transform = value
                },
                 duration: 0.2,
                 id: "transform_\(arc4random())")
        
        _ = transformTween.ease(Cubic.easeOut)
        
        timeline = UTimeline(id: "timeline_\(arc4random())")
        _ = timeline.memoryReference(.weak)
        timeline.insert(tween, at: 0)
        timeline.insert(transformTween, at: 0)
    }
    
    func touchDown() {
        _ = timeline.tweenDirection(.forward).start()
        
        tweenOutline()
    }
    
    func touchUp() {
        _ = timeline.tweenDirection(.reverse).start()
    }
    
    func tweenOutline() {
        let imageView = UIImageView(image: UIImage(named: "CircleOutline")!.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = tintColor
        imageView.frame = frame
        superview!.addSubview(imageView)
        
        let transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        let transformTween = UTweenBuilder
            .to( transform,
                 from: CGAffineTransform(scaleX: 1.0, y: 1.0),
                 update: { (value, progress) in
                    imageView.alpha = 1 - CGFloat(progress)
                    imageView.transform = value
                },
                 duration: 0.5,
                 id: "outline_\(arc4random())")
        
        _ = transformTween.ease(Cubic.easeOut)
        _ = transformTween.complete {
            imageView.removeFromSuperview()
        }
        _ = transformTween.start()
    }
}
