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
        print("deinit \(type(of: self))")
    }
    
    func setupTween() {
        tween = UTweenBuilder
            .to( 10.0,
                 from: 0.0,
                 update: { [unowned self] (value, progress) in
                    self.progressBar.progress = Float(progress)
                    self.tweenLabel.text = "\(round(value * 10.0) / 10.0)"
                },
                 duration: 5,
                 id: "progressTween")
        _ = tween.ease(Cubic.easeOut)
        _ = tween.options(.repeat(1), .yoyo)
        _ = tween.memoryReference(.weak)
        _ = tween.updateTotal { [unowned self] (progressTotal) in
            self.tweenControls.progress(progressTotal)
            self.progressBarTotal.progress = Float(progressTotal)
        }
        _ = tween.repeatCycleChange { [unowned self] cycle in
            self.repeatCycleLabel.text = "\(cycle)"
        }
        _ = tween.complete { [unowned self] in
            self.tweenControls.stop()
        }
    }
}

