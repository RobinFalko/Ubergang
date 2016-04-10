//
//  TransformViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class TransformViewController: UIViewController {
    
    @IBOutlet var testView: UIView!
    
    @IBOutlet var testView2: UIView!
    
    @IBOutlet var testView3: UIView!
    
    var tween: TransformTween?
    var tween2: TransformTween?
    var tween3: TransformTween?
    
    var timeline: UTimeline?
    
    @IBOutlet var slider: UISlider!
    
    override func viewDidLoad() {
        slider.value = 0.0
        
        testView.transform.tx = 0
        testView.transform.ty = 0
        
        var to = testView.transform
        to.ty = 200.0
        
        tween = UTweenBuilder
            .to( to,
                current: { [weak self] in
                    guard let welf = self else {
                        return CGAffineTransform()
                    }
                    return welf.testView.transform },
                update: { [weak self] (value, progress) in
                    guard let welf = self else {
                        return
                    }
                    
                    //welf.slider.value = Float(progress)
                    welf.testView.transform = value },
                duration: 1,
                id: "testView")
            .ease(Ease.linear)
            .memoryReference(.Weak)
        
        
        
        testView2.transform.tx = 0
        testView2.transform.ty = 0
        
        to = testView2.transform
        to.ty = 220.0
        tween2 = UTweenBuilder
            .to( to,
                current: { self.testView2.transform },
                update: { value in self.testView2.transform = value },
                duration: 3,
                id: "testView2")
            .ease(Elastic.easeOut)
        
        
        testView3.transform.tx = 0
        testView3.transform.ty = 0
        
        to = testView3.transform
        to.ty = -200.0
        tween3 = UTweenBuilder
            .to( to,
                current: { self.testView3.transform },
                update: { value in self.testView3.transform = value },
                duration: 1,
                id: "testView3")
            .options(.Repeat(2), .Yoyo)
            .ease(Elastic.easeOut)
        
        timeline = UTimeline(id: "test")
        timeline?.append(tween!)
        timeline?.append(tween2!)
        timeline?.insert(tween3!, at: 0.5)
    }
    
    //var tween: Tweenable?
    @IBAction func start() {
        timeline!.start()
    }
    
    
    @IBAction func stop(sender: UIButton) {
        timeline!.stop()
    }
    
    
    @IBAction func pause(sender: UIButton) {
        timeline!.pause()
    }
    
    
    @IBAction func resume(sender: UIButton) {
        timeline!.resume()
    }
    
    @IBAction func reverse(sender: UIButton) {
        sender.selected = !sender.selected
        sender.setTitle("Forward", forState: .Normal)
        sender.setTitle("Reverse", forState: .Selected)
        
        timeline!.tweenDirection(sender.selected ? .Reverse : .Forward)
    }
    
    
    @IBAction func timeSliderChanged(sender: UISlider) {
        timeline?.progress = Double(sender.value)
    }
}

