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
        case stopped
        case playing
        case pausing
    }
    
    class func instanceFromNib() -> TweenControlsView {
        return UINib(nibName: "TweenControls", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! TweenControlsView
    }
    @IBOutlet var playPauseButton: UIButton!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBOutlet var directionButton: UIButton!
    
    @IBOutlet var progressSlider: UISlider!
    
    var onPlay: (() -> Void)?
    var onStop: (() -> Void)?
    var onPause: (() -> Void)?
    var onResume: (() -> Void)?
    var onDirection: ((_ direction: TweenDirection) -> Void)?
    var onProgress: ((_ value: Double) -> Void)?
    
    var playState: PlayState = .stopped
    
    var currentDerection: TweenDirection = .forward
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        playPauseButton.addTarget(self, action: #selector(TweenControlsView.playPauseResume), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(TweenControlsView.stop), for: .touchUpInside)
        directionButton.addTarget(self, action: #selector(TweenControlsView.toggleDirection), for: .touchUpInside)
        
        progressSlider.addTarget(self, action: #selector(TweenControlsView.sliderValueChanged(_:)), for: .valueChanged)
        
        progressSlider.setThumbImage(UIImage(named: "SliderThumb"), for: UIControl.State())
        progressSlider.setThumbImage(UIImage(named: "SliderThumb"), for: .highlighted)
        
        progress(0)
    }
    
    override func didMoveToSuperview() {
        guard let _ = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        let views = ["v": self]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v]-0-|", options: [], metrics: nil, views: views)
        constraints.append(contentsOf: horizontalConstraints)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[v(64)]-16-|", options: [], metrics: nil, views: views)
        constraints.append(contentsOf: verticalConstraints)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func playPauseResume() {
        switch playState {
        case .stopped:
            playState = .playing
            playPauseButton.isSelected = true
            
            onPlay?()
            break
        case .playing:
            playState = .pausing
            playPauseButton.isSelected = false
            
            onPause?()
            break
        case .pausing:
            playState = .playing
            playPauseButton.isSelected = true
            
            onResume?()
            break
        }
    }
    
    @objc func stop() {
        playState = .stopped
        playPauseButton.isSelected = false
        
        onStop?()
    }
    
    func pause() {
        onPause?()
    }
    
    func resume() {
        onResume?()
    }
    
    @objc func toggleDirection() {
        switch currentDerection {
        case .forward:
            currentDerection = .reverse
            directionButton.isSelected = true
        case .reverse:
            currentDerection = .forward
            directionButton.isSelected = false
        default: break
        }
        
        onDirection?(currentDerection)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider?) {
        onProgress?(Double(sender!.value))
    }
    
    func progress(_ value: Double) {
        progressSlider.value = Float(value)
    }
}
