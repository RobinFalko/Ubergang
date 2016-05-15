//
//  TweenControlsView.swift
//  TweenApp
//
//  Created by RF on 10/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class TweenControlsView: UIView {
    enum PlayState {
        case Stopped
        case Playing
        case Pausing
    }
    
    class func instanceFromNib() -> TweenControlsView {
        return UINib(nibName: "TweenControls", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! TweenControlsView
    }
    @IBOutlet var playPauseButton: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var directionButton: UIButton!
    
    @IBOutlet var progressSlider: UISlider!
    
    var onPlay: (() -> Void)?
    var onStop: (() -> Void)?
    var onPause: (() -> Void)?
    var onResume: (() -> Void)?
    var onDirection: ((direction: TweenDirection) -> Void)?
    var onProgress: ((value: Double) -> Void)?
    
    var playState: PlayState = .Stopped
    
    var currentDerection: TweenDirection = .Forward
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        playPauseButton.addTarget(self, action: #selector(TweenControlsView.playPauseResume), forControlEvents: .TouchUpInside)
        stopButton.addTarget(self, action: #selector(TweenControlsView.stop), forControlEvents: .TouchUpInside)
        directionButton.addTarget(self, action: #selector(TweenControlsView.toggleDirection), forControlEvents: .TouchUpInside)
        
        
        progressSlider.addTarget(self, action: #selector(TweenControlsView.sliderValueChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    override func didMoveToSuperview() {
        guard let _ = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        let views = ["v": self]
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v]-0-|", options: [], metrics: nil, views: views)
        constraints.appendContentsOf(horizontalConstraints)
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[v(64)]-16-|", options: [], metrics: nil, views: views)
        constraints.appendContentsOf(verticalConstraints)
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func playPauseResume() {
        switch playState {
        case .Stopped:
            playState = .Playing
            playPauseButton.selected = true
            
            onPlay?()
            break
        case .Playing:
            playState = .Pausing
            playPauseButton.selected = false
            
            onPause?()
            break
        case .Pausing:
            playState = .Playing
            playPauseButton.selected = true
            
            onResume?()
            break
        }
    }
    
    func stop() {
        playState = .Stopped
        playPauseButton.selected = false
        
        onStop?()
    }
    
    func pause() {
        onPause?()
    }
    
    func resume() {
        onResume?()
    }
    
    func toggleDirection() {
        switch currentDerection {
        case .Forward:
            currentDerection = .Reverse
            directionButton.selected = true
            break
        case .Reverse:
            currentDerection = .Forward
            directionButton.selected = false
            break
        }
        
        onDirection?(direction: currentDerection)
    }
    
    func sliderValueChanged(sender: UISlider?) {
        onProgress?(value: Double(sender!.value))
    }
    
    func progress(value: Double) {
        progressSlider.value = Float(value)
//        onProgress?(value: value)
    }
}
