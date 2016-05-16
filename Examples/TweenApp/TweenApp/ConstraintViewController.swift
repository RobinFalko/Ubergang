//
//  ConstraintViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class ConstraintViewController: ExampleViewController {
    
    @IBOutlet var redViewHeight: NSLayoutConstraint!
    
    @IBOutlet var grayViewWidth: NSLayoutConstraint!
    
    @IBOutlet var greenViewBottom: NSLayoutConstraint!
    
    var defaultRedViewHeight: CGFloat!
    var defaultGrayViewWidth: CGFloat!
    var defaultGreenViewBottom: CGFloat!
    
    var timeline: UTimeline!
    
    override func viewDidLoad() {
        defaultRedViewHeight = redViewHeight.constant
        defaultGrayViewWidth = grayViewWidth.constant
        defaultGreenViewBottom = greenViewBottom.constant
        
        setupTween()
        
        addTweenControls(timeline)
    }
    
    func setupTween() {
        timeline = UTimeline(id: "particleTimeline")
        timeline.memoryReference(.Weak)
        timeline.updateTotal { [unowned self] (progressTotal) in
            self.tweenControls.progress(progressTotal)
        }
        timeline.complete { [unowned self] in
            self.tweenControls.stop()
        }
        
        var from = defaultRedViewHeight
        let tween1 = NumericTween<CGFloat>(id: "testView1")
            .to( CGFloat(50.0),
                current: { from },
                update: { [weak self] (value:CGFloat) in
                    guard let welf = self else {
                        return
                    }
                    
                    welf.redViewHeight.constant = value },
                duration: 1)
            .ease(Linear.ease)
        
        from = defaultGrayViewWidth
        let tween2 = NumericTween<CGFloat>(id: "testView2")
            .to( CGFloat(150.0),
                current: { from },
                update: { [weak self] (value:CGFloat) in
                    guard let welf = self else {
                        return
                    }
                    
                    welf.grayViewWidth.constant = value },
                duration: 3)
            .ease(Elastic.easeOut)
        
        from = defaultGreenViewBottom
        let tween3 = NumericTween<CGFloat>(id: "testView3")
            .to( CGFloat(100.0),
                current: { from },
                update: { [weak self] (value:CGFloat) in
                    guard let welf = self else {
                        return
                    }
                    
                    welf.greenViewBottom.constant = value },
                duration: 3)
            .options(.Repeat(1), .Yoyo)
            .ease(Cubic.easeInOut)
        
        timeline.append(tween1)
        timeline.append(tween2)
        timeline.append(tween3)
    }
}

