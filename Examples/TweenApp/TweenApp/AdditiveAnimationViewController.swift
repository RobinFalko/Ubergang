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
            $0.image = $0.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate);
            $0.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    
    deinit {
        print("deinit \(type(of: self))")
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let position = touch.location(in: view)
        
        selectedView = view.hitTest(position, with: nil)
        if selectedView == view {
           selectedView = nil
        }
        if selectedView != nil {
            view.bringSubview(toFront: selectedView!)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let position = touch.location(in: view)
        
        selectedView?.center.x = position.x
        selectedView?.center.y = position.y
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedView = nil
    }
}

