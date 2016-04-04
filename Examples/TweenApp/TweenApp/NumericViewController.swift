//
//  ViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class NumericViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
    }
    
    var tween: NumericTween<Int>?
    
    @IBAction func start() {
        let test = 0
        
        tween = UTweenBuilder
            .to( 10, current: { test }, update: { value in print("test int: \(value)") }, duration: 5, id: "intTween")
            .ease(Elastic.easeOut)
            .memoryReference(.Weak)
            .start()
        
        print("test: \(test)")
        
        
        let test2 = 0.0
        UTweenBuilder
            .to( 10.0, current: { test2 }, update: { value in print("test double: \(value)") }, duration: 5, id: "doubleTween")
            .ease(Elastic.easeOut)
            .start()
    }
}

