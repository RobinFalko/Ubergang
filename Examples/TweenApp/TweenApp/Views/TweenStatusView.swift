//
//  TweenStatusView.swift
//  TweenApp
//
//  Created by Robin Frielingsdorf on 17/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

class TweenStatusView: UIView {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressBarTotal: UIProgressView!
    @IBOutlet var repeatCountLabel: UILabel!
    
    var title: String = "Tween" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var progress: Float = 0 {
        didSet {
            progressBar.progress = progress
        }
    }
    
    var progressTotal: Float = 0 {
        didSet {
            progressBarTotal.progress = progressTotal
        }
    }
    
    var repeatCount: Int = 0 {
        didSet {
            repeatCountLabel.text = "\(repeatCount)"
        }
    }
    
    
	init() {
        super.init(frame: CGRect.zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        
    }
}