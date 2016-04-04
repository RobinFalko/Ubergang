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
    
    //var tween: Tweenable?
    @IBAction func start() {
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
                update: { [weak self] value in
                    guard let welf = self else {
                        return
                    }
                    
                    welf.testView.transform = value },
                duration: 2.5,
                id: "testView")
            .options(.Repeat(0))
            .ease(Ease.linear)
            .memoryReference(.Weak)
        .start()
        
        testView2.transform.tx = 0
        testView2.transform.ty = 0
        
        to = testView2.transform
        to.ty = 220.0
        tween2 = UTweenBuilder
            .to( to,
                current: { self.testView2.transform },
                update: { value in self.testView2.transform = value },
                duration: 0.5,
                id: "testView2")
            .options(.Repeat(2), .Yoyo)
            .ease(Elastic.easeOut)
        
        testView3.transform.tx = 0
        testView3.transform.ty = 0
        
        to = testView3.transform
        to.ty = -200.0
        tween3 = UTweenBuilder
            .to( to,
                current: { self.testView3.transform },
                update: { value in self.testView3.transform = value },
                duration: 2,
                id: "testView3")
            .options(.Repeat(1))
            .ease(Elastic.easeOut)
    }
    
    
    @IBAction func timeSliderChanged(sender: UISlider) {
        tween?.progress = Double(sender.value)
        tween2?.progress = Double(sender.value)
        tween3?.progress = Double(sender.value)
    }
}

