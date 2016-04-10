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
    
    var tweenControls: TweenControlsView!
    
    var timelineContainer: UTimeline!
    var timeline: UTimeline!
    
    var labelTween: NumericTween<Int>?
    
    override func viewDidLoad() {
        tweenControls = TweenControlsView.instanceFromNib()
        tweenControls.onPlay = { [unowned self] in
            self.timeline.start()
            self.labelTween?.start()
        }
        tweenControls.onStop = { [unowned self] in
            self.timeline.stop()
            self.labelTween?.stop()
        }
        tweenControls.onPause = { [unowned self] in
            self.timeline.pause()
            self.labelTween?.pause()
        }
        tweenControls.onResume = { [unowned self] in
            self.timeline.resume()
            self.labelTween?.resume()
        }
        tweenControls.onProgress = { [unowned self] value in
            self.timeline.progress = value
        }
        view.addSubview(tweenControls)
        
        
        timeline = UTimeline(id: "timeline")
        timeline.memoryReference(.Weak)
        timeline.options(.Repeat(9))
        timeline.update { [unowned self] (progress) in
            self.tweenControls.progress(progress)
        }
        timeline.complete {
            print("complete")
        }
        
        timeline?.append( UTweenBuilder
            .to( CGFloat(0.0),
                current: { CGFloat(-360.0) },
                update: { [unowned self] (value: CGFloat) in
                    self.progressBar.endAngle = value
                },
                duration: 0.5,
                id: "arcIncreaseTween")
            .ease(Cubic.easeInOut))
        
        timeline?.append( UTweenBuilder
            .to( CGFloat(0.0),
                current: { CGFloat(-360.0) },
                update: { [unowned self] (value: CGFloat) in
                    self.progressBar.startAngle = value
                },
                duration: 0.5,
                id: "arcDecreaseTween")
            .ease(Cubic.easeInOut))
        
        
        timelineContainer = UTimeline(id: "timelineContainer")
        timelineContainer.memoryReference(.Weak)
        
        timelineContainer.insert(timeline, at: 0)
        
        
        labelTween = UTweenBuilder
            .to( 0,
                current: { 10 },
                update: { [unowned self] (value: Int) in
                    self.numberLabel.text = String(value)
                },
                duration: 10.0,
                id: "countTween")
            .ease(Ease.linear)
            .memoryReference(.Weak)
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    @IBAction func start() {
        
        
        /*let test2 = 0.0
        UTweenBuilder
            .to( 10.0, current: { test2 }, update: { value in print("test double: \(value)") }, duration: 5, id: "doubleTween")
            .options(.Repeat(2), .Yoyo)
            .ease(Elastic.easeOut)
            .start()*/
    }
}

