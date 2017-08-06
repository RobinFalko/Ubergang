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
        timeline.append(NumericTween().from(0, to: 100).update({ [unowned self] in
            self.viewCenterY.constant = $0
        }))
        
        return timeline
    }
}
