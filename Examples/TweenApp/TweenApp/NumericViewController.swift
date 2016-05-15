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
    
    var tween: NumericTween<Int>!
    
    override func viewDidLoad() {
        
        setupTween()
        
        addTweenControlls(tween)
    }
    
    func setupTween() {
        tween = UTweenBuilder
            .to( 100,
                 current: { 0 },
                 update: { [unowned self] (value:Int, progress: Double) in
                    self.numberLabel.text = "\(value)"
                    self.tweenControls.progress(progress)
                },
                 duration: 5,
                 id: "tween")
        tween.ease(Linear.ease)
        tween.complete {
            self.tweenControls.stop()
        }
    }
}

