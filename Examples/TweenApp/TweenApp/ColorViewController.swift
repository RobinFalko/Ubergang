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

class ColorViewController: ExampleViewController {
    
    @IBOutlet var targetView: UIView!
    
    var random: CGFloat {
        return CGFloat(Double(arc4random_uniform(255)) / 255.0)
    }
    
    override func setupTween() -> UTweenBase {
        let colorTo = UIColor(red: random, green: random, blue: random, alpha: 1.0)
        let colorFrom = UIColor(red: random, green: random, blue: random, alpha: 1.0)
        
        self.targetView.backgroundColor = colorFrom
        
        return colorFrom.tween(to: colorTo)
            .duration(1)
            .update { [unowned self] (value:UIColor, progress: Double) in
                    self.targetView.backgroundColor = value
                    self.tweenControls.progress(progress)
                }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
    }
}

