//
//  ViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Foundation
import Ubergang

class DynamicViewController: ExampleViewController {
    
    @IBOutlet var views: [UIView]!
    
    @IBOutlet var targetView: UIImageView!
    
    var tween: CGPointTween!
    
    override func viewDidLoad() {
        setupTween()
        
        addTweenControls(tween)
    }
    
    deinit {
        print("deinit \(self.dynamicType)")
    }
    
    func setupTween() {
        tween = UTweenBuilder
            .to({ [unowned self] in
                    self.views[1].center
                },
                from: { [unowned self] in
                    self.views[0].center
                },
                 update: { [unowned self] (value:CGPoint, progress: Double) in
                    self.targetView.center = value
                    self.tweenControls.progress(progress)
                },
                 duration: 30,
                 id: "pointTween")
        tween.ease(Linear.ease)
        tween.memoryReference(.Weak)
        tween.complete { [unowned self] in
            self.tweenControls.stop()
        }
    }
    
    var selectedView: UIView?
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let position = touch.locationInView(view)
        
        selectedView = view.hitTest(position, withEvent: nil)
        if selectedView != nil {
            view.bringSubviewToFront(selectedView!)
        }
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let position = touch.locationInView(view)
        
        selectedView?.center.x = position.x
        selectedView?.center.y = position.y
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        selectedView = nil
    }
}

