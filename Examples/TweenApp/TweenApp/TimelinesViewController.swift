//
//  ViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class TimelinesViewController: ExampleViewController {
    
    @IBOutlet var numberLabel: UILabel!
    
    @IBOutlet var progressBar: CircularProgressBar!
    
    var timelineContainer: UTimeline!
    
    var labelTween: NumericTween<Int>?
    
    deinit {
        print("deinit controller")
    }
    
    override func viewDidLoad() {
        setupTween()
        
        addTweenControls(timelineContainer)
    }
    
    func setupTween() {
        
        let timeline = UTimeline(id: "timeline")
        timeline.options(.Repeat(9))
        timeline.updateTotal { [unowned self] (progressTotal) in
            self.tweenControls.progress(progressTotal)
        }
        
        //closing arc
        timeline.append(UTweenBuilder
            .to( CGFloat(-0.1),
                current: { CGFloat(-360.0) },
                update: { [unowned self] (value: CGFloat, progress: Double) in
                    self.progressBar.endAngle = value
                },
                duration: 5,
                id: "arcIncreaseTween")
            .ease(Cubic.easeInOut))
        
        //opening arc
        timeline.append(UTweenBuilder
            .to( CGFloat(-0.1),
                current: { CGFloat(-360.0) },
                update: { [unowned self] (value: CGFloat) in
                    self.progressBar.startAngle = value
                },
                duration: 5,
                id: "arcDecreaseTween")
            .ease(Cubic.easeInOut))
        
        
        timelineContainer = UTimeline(id: "timelineContainer").memoryReference(.Weak)
        timelineContainer.complete { [unowned self] in
            self.tweenControls.stop()
        }
        
        //timeline arcs
        timelineContainer.insert(timeline, at: 0)
        
        //countdown
        timelineContainer.insert( UTweenBuilder
            .to( 0,
                current: { 10 },
                update: { [unowned self] (value: Int) in
                    self.numberLabel.text = String(value)
                },
                duration: 10.0,
                id: "countTween")
            .ease(Linear.ease)
            .memoryReference(.Weak), at: 0.0)
    }
}

