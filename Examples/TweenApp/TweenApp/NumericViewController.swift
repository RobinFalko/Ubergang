//
//  ViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class NumericViewController: ExampleViewController {
    @IBOutlet var numberLabel: UILabel!
    
    override func setupTween() -> UTweenBase {
        return 0.tween(to:100)
            .update { [unowned self] (value:Int, progress: Double) in
                self.numberLabel.text = "\(value)"
                self.tweenControls.progress(progress)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
        }
    }
}

