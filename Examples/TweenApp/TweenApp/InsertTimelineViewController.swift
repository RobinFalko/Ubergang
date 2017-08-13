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
    @IBOutlet var viewCenterX: NSLayoutConstraint!
    
    override func setupTween() -> UTweenBase {
        let timeline = UTimeline()
            .options(.repeat(1))
            .updateTotal { [unowned self] in
                self.tweenControls.progress($0)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
        
        //time 0 to 0.5
        timeline.append(CGFloat(0).tween(to: 100).update({ [unowned self] (value: CGFloat) in
                self.viewCenterY.constant = value
            })
        )
        
        //time 4 to 4.5
        timeline.insert(CGFloat(0).tween(to: 100).update({ [unowned self] in
            self.viewCenterX.constant = $0
        }), at: 4)
        
        //time 5 to 7
        timeline.insert(CGFloat(100).tween(to: -100).update({ [unowned self] (value: CGFloat) in
                self.viewCenterX.constant = value
                self.viewCenterY.constant = value
            })
            .duration(2)
        , at: 5)
        
        //time 7 to 9
        timeline.insert(CGFloat(-100).tween(to: 0).update({ [unowned self] (value: CGFloat) in
                self.viewCenterX.constant = value
            })
            .duration(2)
        , at: 7)
        
        //time 9.5 to 10
        timeline.insert(CGFloat(-100).tween(to: 0).update({ [unowned self] in
            self.viewCenterY.constant = $0
        }), at: 9.5)
        
        return timeline
    }
}
