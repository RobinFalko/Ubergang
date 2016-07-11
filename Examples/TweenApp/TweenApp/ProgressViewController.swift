//
//  ProgressViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class ProgressViewController: ExampleViewController {
    
    var tween: NumericTween<Double>!
    
    @IBOutlet var tweenLabel: UILabel!
    
    @IBOutlet var progressBar: UIProgressView!
    
    @IBOutlet var progressBarTotal: UIProgressView!
    
    @IBOutlet var repeatCycleLabel: UILabel!
    
    var direction = false
    override func viewDidLoad() {
        self.progressBar.progress = 0.0
        self.progressBarTotal.progress = 0.0
        
        setupTween()
        
        addTweenControls(tween)
    }
    
    deinit {
        print("deinit \(self.dynamicType)")
    }
    
    func setupTween() {
        tween = UTweenBuilder
            .to( 10.0,
                 current: 0.0,
                 update: { [unowned self] (value, progress) in
                    self.progressBar.progress = Float(progress)
                    self.tweenLabel.text = "\(round(value * 10.0) / 10.0)"
                },
                 duration: 5,
                 id: "progressTween")
        tween.ease(Cubic.easeOut)
        tween.options(.Repeat(1), .Yoyo)
        tween.memoryReference(.Weak)
        tween.updateTotal { [unowned self] (progressTotal) in
            self.tweenControls.progress(progressTotal)
            self.progressBarTotal.progress = Float(progressTotal)
        }
        tween.repeatCycleChange { [unowned self] cycle in
            self.repeatCycleLabel.text = "\(cycle)"
        }
        tween.complete { [unowned self] in
            self.tweenControls.stop()
        }
    }
}

