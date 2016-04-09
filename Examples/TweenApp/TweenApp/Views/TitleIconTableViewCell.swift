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
    
    var timeline: UTimeline<CGFloat>!
    
    override func awakeFromNib() {
        setup()
    }
    
    
    func animateIn() {
        timeline.start()
    }
    
    func progress(value: Double) {
        timeline.progress = value
    }
    
    func setup() {
        timeline = UTimeline(id: "timeline \(arc4random())")
        
        let from = CGFloat(120)
        let duration = 0.4
        
        timeline.insert(
            UTweenBuilder
                .to( titleLabel.constant,
                    current: { from },
                    update: { [weak self] (value, progress) in
                        guard let welf = self else {
                            return
                        }
                        
                        welf.titleLabel.constant = value
                        },
                    duration: duration,
                    id: "titleLabelTween")
                .ease(Cubic.easeOut)
            , at: 0)
        
        
        
        timeline.insert(
            UTweenBuilder
                .to( iconView.constant,
                    current: { from },
                    update: { [weak self] (value, progress) in
                        guard let welf = self else {
                            return
                        }
                        
                        welf.iconView.constant = value },
                    duration: duration,
                    id: "iconViewTween")
                .ease(Cubic.easeOut)
            , at: 0)
        
    }
}
