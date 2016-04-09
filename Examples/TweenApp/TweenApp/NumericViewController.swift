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
    
    @IBOutlet var numberLabel: UILabel!
    
    @IBOutlet var progressBar: CircularProgressBar!
    
    var timeline: UTimeline<CGFloat>?
    
    var labelTween: NumericTween<Int>?
    
    override func viewDidLoad() {
        
        timeline = UTimeline(id: "timeline")
        timeline?.memoryReference(.Weak)
        timeline?.options(.Repeat(9))
        
        timeline?.append( UTweenBuilder
            .to( CGFloat(0.0),
                current: { CGFloat(-360.0) },
                update: { [unowned self] (value: CGFloat) in
                    self.progressBar.endAngle = value
                },
                duration: 0.5,
                id: "arcIncreaseTween")
            .ease(Cubic.easeInOut)
            .memoryReference(.Weak))
        
        timeline?.append( UTweenBuilder
            .to( CGFloat(0.0),
                current: { CGFloat(-360.0) },
                update: { [unowned self] (value: CGFloat) in
                    self.progressBar.startAngle = value
                },
                duration: 0.5,
                id: "arcDecreaseTween")
            .ease(Cubic.easeInOut)
            .memoryReference(.Weak))
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    @IBAction func start() {
        labelTween = UTweenBuilder
            .to( 0,
                current: { 10 },
                update: { [unowned self] value in
                self.numberLabel.text = String(value)
                },
                duration: 10.0,
                id: "countTween")
            .ease(Ease.linear)
            .memoryReference(.Weak)
            .start()
        
        timeline?.options(.Repeat(9))
        timeline?.start()
        
        
        /*let test2 = 0.0
        UTweenBuilder
            .to( 10.0, current: { test2 }, update: { value in print("test double: \(value)") }, duration: 5, id: "doubleTween")
            .options(.Repeat(2), .Yoyo)
            .ease(Elastic.easeOut)
            .start()*/
    }
}

