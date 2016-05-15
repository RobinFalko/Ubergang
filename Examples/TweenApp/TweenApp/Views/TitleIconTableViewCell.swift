//
//  TitleIconTableViewCell.swift
//  TweenApp
//
//  Created by RF on 08/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class TitleIconTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: NSLayoutConstraint!
    @IBOutlet var iconView: NSLayoutConstraint!
    
    var timeline: UTimeline!
    
    override func awakeFromNib() {
        setup()
    }
    
    
    func animateIn() {
        timeline.start()
    }
    
//    func progress(value: Double) {
//        timeline.progress = value
//    }
    
    func setup() {
        timeline = UTimeline(id: "timeline \(arc4random())")
        
        let from = CGFloat(120)
        let duration = 0.4
        
        let labelTween: NumericTween<CGFloat> =
            UTweenBuilder
                .to( titleLabel.constant,
                    current: { from },
                    update: { [unowned self] value in
                        self.titleLabel.constant = value
                    },
                    duration: duration,
                    id: "titleLabelTween")
                .ease(Cubic.easeOut)
        
        let dotTween: NumericTween<CGFloat> =
            UTweenBuilder
                .to( iconView.constant,
                    current: { from },
                    update: { [unowned self] value in
                        self.iconView.constant = value },
                    duration: duration,
                    id: "iconViewTween")
                .ease(Cubic.easeOut)
        
        timeline.insert(labelTween, at: 0)
        timeline.insert(dotTween, at: 0)
        
    }
}