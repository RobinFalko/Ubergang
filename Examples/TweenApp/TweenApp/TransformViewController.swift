//
//  TransformViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class TransformViewController: ExampleViewController {
    @IBOutlet var testView: UIView!
    @IBOutlet var slider: UISlider!
    
    override func setupTween() -> UTweenBase {
        testView.transform = CGAffineTransform.identity
        
        var to = CGAffineTransform(scaleX: 2, y: 2)
        to = to.rotated(by: CGFloat(Double.pi / 2))
        
        return TransformTween(id: "transformTween")
            .from(testView.transform, to: to)
            .update { [unowned self] (value, progress) in
                    self.testView.transform = value
            }
            .duration(4)
            .ease(Elastic.easeOut)
            .reference(.weak)
            .updateTotal { [unowned self] (progressTotal) in
                self.tweenControls.progress(progressTotal)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
    }
}

