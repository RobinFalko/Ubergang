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
    
    func addTweenControls(tween: UTweenBase) {
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
            tween.tweenDirection(value)
        }
        tweenControls.onProgress = { value in
            tween.progressTotal = value
        }
        view.addSubview(tweenControls)
    }
}
