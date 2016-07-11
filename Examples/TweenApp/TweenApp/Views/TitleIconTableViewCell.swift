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
    
    @IBOutlet var titleLabelConstraints: NSLayoutConstraint!
    @IBOutlet var iconViewConstraints: NSLayoutConstraint!
    
    @IBOutlet var iconView: UIImageView!
    
    var timeline: UTimeline!
    
    override func awakeFromNib() {
        iconView.image = iconView.image?.imageWithRenderingMode(.AlwaysTemplate)
        
        var color: UIColor?
        if userInteractionEnabled {
            color = UIColor(red: 77.0 / 255.0, green: 209.0 / 255.0, blue: 0.0, alpha: 0.75)
        } else {
            color = UIColor(red: 0.0, green: 148.0 / 255.0, blue: 209.0 / 255.0, alpha: 0.75)
        }
        iconView.tintColor = color
        
        setup()
    }
    
    
    func animateIn() {
        timeline.start()
    }
    
    func setup() {
        timeline = UTimeline(id: "timeline \(arc4random())")
        
        let from = CGFloat(120)
        let duration = 0.4
        
        let labelTween: NumericTween<CGFloat> =
            UTweenBuilder
                .to( titleLabelConstraints.constant,
                    current: from,
                    update: { [unowned self] value in
                        self.titleLabelConstraints.constant = value
                    },
                    duration: duration,
                    id: "titleLabelTween")
                .ease(Cubic.easeOut)
        
        let dotTween: NumericTween<CGFloat> =
            UTweenBuilder
                .to( iconViewConstraints.constant,
                    current: from,
                    update: { [unowned self] value in
                        self.iconViewConstraints.constant = value },
                    duration: duration,
                    id: "iconViewTween")
                .ease(Cubic.easeOut)
        
        timeline.insert(labelTween, at: 0)
        timeline.insert(dotTween, at: 0)
    }
}
