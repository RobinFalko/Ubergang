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
    
    var tween: ColorTween!
    
    var random: CGFloat {
        return CGFloat(Double(arc4random_uniform(255)) / 255.0)
    }
    
    override func viewDidLoad() {
        
        setupTween()
        
        addTweenControls(tween)
    }
    
    deinit {
        print("deinit \(self.dynamicType)")
    }
    
    func setupTween() {
        let colorTo = UIColor(red: random, green: random, blue: random, alpha: 1.0)
        let colorFrom = UIColor(red: random, green: random, blue: random, alpha: 1.0)
        
        self.targetView.backgroundColor = colorFrom
        
        tween = UTweenBuilder
            .to( colorTo,
                 from: colorFrom,
                 update: { [unowned self] (value:UIColor, progress: Double) in
                    self.targetView.backgroundColor = value
                    self.tweenControls.progress(progress)
                },
                 duration: 1,
                 id: "colorTween")
        tween.ease(Linear.ease)
        tween.memoryReference(.Weak)
        tween.complete { [unowned self] in
            self.tweenControls.stop()
        }
    }
}

