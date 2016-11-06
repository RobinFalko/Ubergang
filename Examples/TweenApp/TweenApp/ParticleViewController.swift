//
//  ParticleViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class ParticleViewController: ExampleViewController {
    
    var numTweens: UInt32 = 500
    
    var particles = [UIView]()
    
    var timeline: UTimeline!
    
    
    override func viewDidLoad() {
        createViews()
        
        setupTween()
        
        addTweenControls(timeline)
    }
    
    deinit {
        print("deinit \(type(of: self))")
    }
    
    func setupTween() {
        timeline = UTimeline(id: "particleTimeline")
        _ = timeline.updateTotal { [unowned self] (progressTotal) in
            self.tweenControls.progress(progressTotal)
        }
        _ = timeline.complete { [unowned self] in
            self.tweenControls.stop()
        }
        
        for i in 0..<particles.count {
            let view = particles[i]
            
            let ui = UInt32(i)
            var to = view.transform
            to.tx = view.transform.tx + CGFloat(arc4random_uniform(ui)) * CGFloat(arc4random_uniform(2) == 0 ? -1 : 1)
            to.ty = view.transform.ty + CGFloat(arc4random_uniform(ui)) * CGFloat(arc4random_uniform(2) == 0 ? -1 : 1)
            
            let tween = UTweenBuilder
                .to( to, from: view.transform, update: { value in view.transform = value }, duration: 3, id: "id-\(i)")
                .ease(Cubic.easeInOut)
                .options(.yoyo)
            timeline.insert(tween, at: 0)
            _ = timeline.memoryReference(.weak)
        }
    }
    
    func createViews() {
        let bounds = UIScreen.main.bounds
        
        for _: UInt32 in 0..<numTweens {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
            view.backgroundColor = UIColor.blue
            self.view.addSubview(view)
            
            view.transform.tx = bounds.width * 0.5
            view.transform.ty = bounds.height * 0.5
            
            self.particles.append(view)
        }
    }
}

