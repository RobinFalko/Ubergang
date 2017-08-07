//
//  ExampleViewController.swift
//  TweenApp
//
//  Created by RF on 15/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class ExampleViewController: UIViewController {
    
    var tweenControls: TweenControlsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTweenControls(setupTween())
    }
    
    deinit {
        print("deinit \(type(of: self))")
    }
    
    func setupTween() -> UTweenBase {
        //override
        return UTween<Void>()
    }
    
    func addTweenControls(_ tween: UTweenBase) {
        tweenControls = TweenControlsView.instanceFromNib()
        tweenControls.progress(0.0)
        tweenControls.onPlay = {
            tween.start()
        }
        tweenControls.onStop = {
            tween.stop()
        }
        tweenControls.onPause = {
            tween.pause()
        }
        tweenControls.onResume = {
            tween.resume()
        }
        tweenControls.onDirection = { value in
            tween.direction(value)
        }
        tweenControls.onProgress = { value in
            tween.progressTotal = value
        }
        view.addSubview(tweenControls)
        
        tween.progressTotal = 0
    }
}
