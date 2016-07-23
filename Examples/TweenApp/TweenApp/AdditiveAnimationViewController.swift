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

class AdditiveAnimationViewController: ExampleViewController {
    
    
    @IBOutlet var views: [UIImageView]!
    
    @IBOutlet var targetView: UIImageView!
    
    var tween: CGPointTween!
    
    override func viewDidLoad() {
        self.setupTween()
        self.addTweenControls(tween)
        
        views.forEach {
            $0.image = $0.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate);
            $0.translatesAutoresizingMaskIntoConstraints = true
        }
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
                },
                duration: 5,
                id: "pointTween")
            .ease(Cubic.easeOut)
            .updateTotal { [unowned self] progressTotal in
                self.tweenControls.progress(progressTotal)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
        }
    }
    
    var selectedView: UIView?
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let position = touch.locationInView(view)
        
        selectedView = view.hitTest(position, withEvent: nil)
        if selectedView == view {
           selectedView = nil
        }
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

