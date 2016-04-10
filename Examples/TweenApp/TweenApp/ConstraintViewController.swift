//
//  ConstraintViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class ConstraintViewController: UIViewController {
    
    @IBOutlet var redViewHeight: NSLayoutConstraint!
    
    @IBOutlet var grayViewWidth: NSLayoutConstraint!
    
    @IBOutlet var greenViewBottom: NSLayoutConstraint!
    
    var defaultRedViewHeight: CGFloat!
    var defaultGrayViewWidth: CGFloat!
    var defaultGreenViewBottom: CGFloat!
    
    var tween1: NumericTween<CGFloat>?
    var tween2: NumericTween<CGFloat>?
    
    override func viewDidAppear(animated: Bool) {
        defaultRedViewHeight = redViewHeight.constant
        defaultGrayViewWidth = grayViewWidth.constant
        defaultGreenViewBottom = greenViewBottom.constant
    }
    
    //var tween: Tweenable?
    @IBAction func start() {
        var from = defaultRedViewHeight
        tween1 = NumericTween<CGFloat>(id: "testView1")
            .to( CGFloat(10.0),
                current: { from },
                update: { [weak self] (value:CGFloat) in
                    guard let welf = self else {
                        return
                    }
                    
                    welf.redViewHeight.constant = value },
                duration: 2.5)
            .options(.Repeat(0))
            .ease(Ease.linear)
            .memoryReference(.Weak)
            .start()
        
        from = defaultGrayViewWidth
        tween2 = NumericTween<CGFloat>(id: "testView2")
            .to( CGFloat(100.0),
                current: { from },
                update: { [weak self] (value:CGFloat) in
                    guard let welf = self else {
                        return
                    }
                    
                    welf.grayViewWidth.constant = value },
                duration: 0.5)
            .options(.Repeat(Int.max), .Yoyo)
            .ease(Cubic.easeInOut)
            .memoryReference(.Weak)
            .start()
        
        
        
        from = defaultGreenViewBottom
        NumericTween<CGFloat>(id: "testView3")
            .to( CGFloat(50.0),
                current: { from },
                update: { [weak self] (value:CGFloat) in
                    guard let welf = self else {
                        return
                    }
                    
                    welf.greenViewBottom.constant = value },
                duration: 1.5)
            .options(.Repeat(1))
            .ease(Elastic.easeOut)
            .start()
    }
    
    @IBAction func timeSliderChanged(sender: UISlider) {
        tween1?.progress = Double(sender.value)
    }
}

