//
//  TransformViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class TransformViewController: ExampleViewController {
    
    @IBOutlet var testView: UIView!
    
    var tween: TransformTween!
    
    @IBOutlet var slider: UISlider!
    
    override func viewDidLoad() {
        setupTween()
        
        addTweenControls(tween)
    }
    
    deinit {
        print("deinit controller")
    }
    
    func setupTween() {
        testView.transform = CGAffineTransformIdentity
        
        var to = CGAffineTransformMakeScale(2, 2)
        to = CGAffineTransformRotate(to, CGFloat(M_PI_2))
        
        tween = UTweenBuilder
            .to( to,
                current: { [unowned self] in
                    self.testView.transform },
                update: { [unowned self] (value, progress) in
                    self.testView.transform = value },
                duration: 4,
                id: "testViewTween")
            .ease(Elastic.easeOut)
            .memoryReference(.Weak)
        
        tween.updateTotal { [unowned self] (progressTotal) in
            self.tweenControls.progress(progressTotal)
        }
        tween.complete { [unowned self] in
            self.tweenControls.stop()
        }
    }
}

