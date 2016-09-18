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
        
        addTweenControls(tween)
    }
    
    deinit {
        print("deinit \(self.dynamicType)")
    }
    
    func setupTween() {
        tween = NumericTween<Int>(id: "tween")
            .to( 100,
                 from: 0,
                 update: { [unowned self] (value:Int, progress: Double) in
                    self.numberLabel.text = "\(value)"
                    self.tweenControls.progress(progress)
                },
                 duration: 5)
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
    }
}

