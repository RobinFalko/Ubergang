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
    
    override func setupTween() -> UTweenBase {
        let timeline = UTimeline(id: "timeline")
            .options(.repeat(9))
            .repeatCycleChange { [unowned self] repeatCycle in
                self.tweenStatusView2.repeatCount = repeatCycle
            }
            .update { [unowned self] progress in
                self.tweenStatusView2.progress = Float(progress)
            }
            .updateTotal { [unowned self] progressTotal in
                self.tweenStatusView2.progressTotal = Float(progressTotal)
                self.tweenControls.progress(progressTotal)
            }
        
        //closing arc
        let tween0 = NumericTween(id: "arcIncreaseTween")
            .from(-360.0, to: -0.1)
            .update { [unowned self] (value: CGFloat, progress: Double) in
                self.tweenStatusView0.progress = Float(progress)
                self.progressBar.endAngle = value
            }
            .duration(5)
            .ease(Cubic.easeInOut)
            .updateTotal { [unowned self] progress in
                self.tweenStatusView0.progressTotal = Float(progress)
            }
        timeline.append(tween0)
        
        let tween1 = NumericTween(id: "arcDecreaseTween")
            .from(-360, to: -0.1)
            .update { [unowned self] (value: CGFloat, progress: Double) in
                self.tweenStatusView1.progress = Float(progress)
                self.progressBar.startAngle = value
            }
            .duration(5)
            .ease(Cubic.easeInOut)
            .updateTotal { [unowned self] progress in
                self.tweenStatusView1.progressTotal = Float(progress)
            }
        //opening arc
        timeline.append(tween1)
        
        
        let timelineContainer = UTimeline(id: "timelineContainer")
            .reference(.weak)
            .repeatCycleChange { [unowned self] repeatCycle in
                self.tweenStatusView3.repeatCount = repeatCycle
            }
            .update { [unowned self] progress in
                self.tweenStatusView3.progress = Float(progress)
            }
            .updateTotal { [unowned self] progressTotal in
                self.tweenStatusView3.progressTotal = Float(progressTotal)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
        
        //timeline arcs
        timelineContainer.insert(timeline, at: 0)
        
        //countdown
        timelineContainer.insert( NumericTween(id: "countTween")
            .from(10, to: 0)
            .update { [unowned self] (value: Int) in
                self.numberLabel.text = String(value)
            }
            .duration(10)
            .ease(Linear.ease)
            .reference(.weak), at: 0)
        
        
        self.tweenStatusView0.title = "\(tween0.id)"
        self.tweenStatusView1.title = "\(tween1.id)"
        self.tweenStatusView2.title = "\(timeline.id)"
        self.tweenStatusView3.title = "\(timelineContainer.id)"
        
        return timelineContainer
    }
}

