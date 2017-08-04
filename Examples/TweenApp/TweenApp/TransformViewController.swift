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
        print("deinit \(type(of: self))")
    }
    
    func setupTween() {
        testView.transform = CGAffineTransform.identity
        
        var to = CGAffineTransform(scaleX: 2, y: 2)
        to = to.rotated(by: CGFloat(Double.pi / 2))
        
        tween = UTweenBuilder
            .to(to,
                 from: testView.transform,
                update: { [unowned self] (value, progress) in
                    self.testView.transform = value },
                duration: 4,
                id: "testViewTween")
            .ease(Elastic.easeOut)
            .memoryReference(.weak)
        
        _ = tween.updateTotal { [unowned self] (progressTotal) in
            self.tweenControls.progress(progressTotal)
        }
        _ = tween.complete { [unowned self] in
            self.tweenControls.stop()
        }
    }
}

