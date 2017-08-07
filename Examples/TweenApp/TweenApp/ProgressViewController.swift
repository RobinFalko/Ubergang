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
    @IBOutlet var tweenLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressBarTotal: UIProgressView!
    @IBOutlet var repeatCycleLabel: UILabel!
    
    var direction = false
    
    override func setupTween() -> UTweenBase {
        return 0.0.tween(to: 10)
            .id("progressTween")
            .duration(5)
            .ease(Cubic.easeOut)
            .options(.repeat(1), .yoyo)
            .reference(.weak)
            .update { [unowned self] (value, progress) in
                self.progressBar.progress = Float(progress)
                self.tweenLabel.text = "\(round(value * 10.0) / 10.0)"
            }
            .updateTotal { [unowned self] (progressTotal) in
                self.tweenControls.progress(progressTotal)
                self.progressBarTotal.progress = Float(progressTotal)
            }
            .repeatCycleChange { [unowned self] cycle in
                self.repeatCycleLabel.text = "\(cycle)"
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
    }
}

