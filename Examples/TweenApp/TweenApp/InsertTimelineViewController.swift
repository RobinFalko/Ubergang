//
//  InsertTimelineViewController.swift
//  TweenApp
//
//  Created by RF on 05.08.17.
//  Copyright © 2017 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class InsertTimelineViewController: ExampleViewController {
    
    @IBOutlet var viewCenterY: NSLayoutConstraint!
    
    override func setupTween() -> UTweenBase {
        let timeline = UTimeline()
            .update { [unowned self] in
                self.tweenControls.progress($0)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
        
        timeline.append(CGFloat(-150).tween(to: 150)
            .ease(Linear.ease)
            .duration(2)
            .update({ [unowned self] (value: CGFloat) in
                self.viewCenterY.constant = value
            }))
        
        timeline.insert(CGFloat(150).tween(to: 0).update({ [unowned self] in
            self.viewCenterY.constant = $0
        }), at: 4)
        
        return timeline
    }
}
