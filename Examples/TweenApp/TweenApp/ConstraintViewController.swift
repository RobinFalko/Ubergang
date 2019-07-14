//
//  ConstraintViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class ConstraintViewController: ExampleViewController {
    @IBOutlet var redViewHeight: NSLayoutConstraint!
    @IBOutlet var grayViewWidth: NSLayoutConstraint!
    @IBOutlet var greenViewBottom: NSLayoutConstraint!
    
    var defaultRedViewHeight: CGFloat!
    var defaultGrayViewWidth: CGFloat!
    var defaultGreenViewBottom: CGFloat!
    
    override func loadView() {
        super.loadView()
        
        defaultRedViewHeight = redViewHeight.constant
        defaultGrayViewWidth = grayViewWidth.constant
        defaultGreenViewBottom = greenViewBottom.constant
    }
    
    override func setupTween() -> UTweenBase {
        let timeline = UTimeline()
            .reference(.weak)
            .updateTotal { [unowned self] (progressTotal) in
                self.tweenControls.progress(progressTotal)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
        
        let tween1 = defaultRedViewHeight!.tween(to: 50)
            .update { [unowned self] in
                self.redViewHeight.constant = $0
            }
            .duration(1)
            .ease(.quint(.inOut))
        
        let tween2 = defaultGrayViewWidth!.tween(to: 150)
            .update { [unowned self] in
                self.grayViewWidth.constant = $0
            }
            .duration(2)
            .ease(.bounce(.out))
        
        let tween3 = defaultGreenViewBottom!.tween(to: 100)
            .update { [unowned self] in
                self.greenViewBottom.constant = $0
            }
            .duration(3)
            .options(.repeat(1), .yoyo)
            .ease(.expo(.inOut))
        
        timeline.append(tween1)
        timeline.append(tween2)
        timeline.append(tween3)
        
        return timeline
    }
}
