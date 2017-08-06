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
        super.viewDidLoad()
        
        views.forEach {
            $0.image = $0.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate);
            $0.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    
    override func setupTween() -> UTweenBase {
        return CGPointTween(id: "pointTween")
            .from({ [unowned self] in
                self.views[0].center
            }, to:{ [unowned self] in
                self.views[1].center
            })
            .update { [unowned self] (value:CGPoint, progress: Double) in
                self.targetView.center = value
            }
            .updateTotal { [unowned self] progressTotal in
                self.tweenControls.progress(progressTotal)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
            .duration(5)
            .ease(Cubic.easeOut)
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

