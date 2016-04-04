//
//  ParticleViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class ParticleViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var numTweensLabel: UILabel!
    
    @IBAction func valueChanged(sender: UISlider) {
        numTweens = UInt32(sender.value * Float(maxTweens))
        numTweensLabel.text = "\(numTweens)"
        
        createViews()
    }
    
    var numTweens: UInt32 = 1
    
    let maxTweens: UInt32 = 5000
    
    var particles = [UIView]()
    
    override func viewWillAppear(animated: Bool) {
        slider.value = Float(numTweens) / Float(maxTweens)
        numTweensLabel.text = "\(numTweens)"
        
        createViews()
    }
    
    override func viewDidDisappear(animated: Bool) {
        clearViews()
    }
    
    deinit {
        print("deinit controller")
    }
    
    func createViews() {
        clearViews()
        
        let bounds = UIScreen.mainScreen().bounds
        
        for _: UInt32 in 0..<numTweens {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
            view.backgroundColor = UIColor.blueColor()
            self.view.sendSubviewToBack(view)
            self.view.addSubview(view)
            
            view.transform.tx = bounds.width * 0.5
            view.transform.ty = bounds.height * 0.5
            
            self.particles.append(view)
        }
    }
    
    func clearViews() {
        for p in self.particles {
            if let _ = p.superview {
                p.removeFromSuperview()
            }
        }
        self.particles.removeAll()
    }
    
    @IBAction func start() {
        for i: UInt32 in 0..<UInt32(particles.count) {
            let view = particles[Int(i)]
            
            var to = view.transform
            to.tx = view.transform.tx + CGFloat(arc4random_uniform(i * 1)) * CGFloat(arc4random_uniform(2) == 0 ? -1 : 1) + 200
            to.ty = view.transform.ty + CGFloat(arc4random_uniform(i * 1)) * CGFloat(arc4random_uniform(2) == 0 ? -1 : 1) + 200
            
            UTweenBuilder
                .to( to, current: { view.transform }, update: { value in view.transform = value }, duration: 1, id: "id-\(i)")
                .options(.Repeat(1))
                .ease(Cubic.easeOut)
                .complete {
                    print("particles complete") }
                .options(.Yoyo)
                .start()
        }
    }
}

