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
    
    @IBOutlet weak var tweenStatusView0: TweenStatusView!
    
    @IBOutlet weak var tweenStatusView1: TweenStatusView!
    
    @IBOutlet weak var tweenStatusView2: TweenStatusView!
    
    @IBOutlet weak var tweenStatusView3: TweenStatusView!
    
    
    @IBOutlet var numberLabel: UILabel!
    
    @IBOutlet var progressBar: CircularProgressBar!
    
    
    
    var timelineContainer: UTimeline!
    
    var labelTween: NumericTween<Int>?
    
    deinit {
        print("deinit \(self.dynamicType)")
    }
    
    override func viewDidLoad() {
        setupTween()
        
        addTweenControls(timelineContainer)
    }
    
    func setupTween() {
        
        let timeline = UTimeline(id: "timeline")
        timeline.options(.Repeat(9))
        timeline.repeatCycleChange { [unowned self] repeatCycle in
            self.tweenStatusView2.repeatCount = repeatCycle
        }
        timeline.update { [unowned self] progress in
            self.tweenStatusView2.progress = Float(progress)
        }
        timeline.updateTotal { [unowned self] progressTotal in
            self.tweenStatusView2.progressTotal = Float(progressTotal)
            self.tweenControls.progress(progressTotal)
        }
        
        //closing arc
        let tween0 = UTweenBuilder
            .to( CGFloat(-0.1),
                from: CGFloat(-360.0),
                update: { [unowned self] (value: CGFloat, progress: Double) in
                    self.tweenStatusView0.progress = Float(progress)
                    self.progressBar.endAngle = value
                },
                duration: 5,
                id: "arcIncreaseTween")
            .ease(Cubic.easeInOut)
        tween0.updateTotal { [unowned self] progress in
            self.tweenStatusView0.progressTotal = Float(progress)
        }
        timeline.append(tween0)
        
        let tween1 = UTweenBuilder
            .to( CGFloat(-0.1),
                from: CGFloat(-360.0),
                update: { [unowned self] (value: CGFloat, progress: Double) in
                    self.tweenStatusView1.progress = Float(progress)
                    self.progressBar.startAngle = value
                },
                duration: 5,
                id: "arcDecreaseTween")
            .ease(Cubic.easeInOut)
        tween1.updateTotal { [unowned self] progress in
            self.tweenStatusView1.progressTotal = Float(progress)
        }
        //opening arc
        timeline.append(tween1)
        
        
        timelineContainer = UTimeline(id: "timelineContainer").memoryReference(.Weak)
        timelineContainer.repeatCycleChange { [unowned self] repeatCycle in
            self.tweenStatusView3.repeatCount = repeatCycle
        }
        timelineContainer.update { [unowned self] progress in
            self.tweenStatusView3.progress = Float(progress)
        }
        timelineContainer.updateTotal { [unowned self] progressTotal in
            self.tweenStatusView3.progressTotal = Float(progressTotal)
        }
        timelineContainer.complete { [unowned self] in
            self.tweenControls.stop()
        }
        
        //timeline arcs
        timelineContainer.insert(timeline, at: 0)
        
        //countdown
        timelineContainer.insert( UTweenBuilder
            .to( 0,
                from: 10,
                update: { [unowned self] (value: Int) in
                    self.numberLabel.text = String(value)
                },
                duration: 10.0,
                id: "countTween")
            .ease(Linear.ease)
            .memoryReference(.Weak), at: 0.0)
        
        
        self.tweenStatusView0.title = "\(tween0.id)"
        self.tweenStatusView1.title = "\(tween1.id)"
        self.tweenStatusView2.title = "\(timeline.id)"
        self.tweenStatusView3.title = "\(timelineContainer.id)"
    }
}

