//
//  ViewController.swift
//  DGDrawRectAnimationTutorial
//
//  Created by Danil Gontovnik on 9/24/15.
//  Copyright © 2015 Danil Gontovnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: -
    // MARK: Vars
    
    private var playButton: PlayButton!
    private var caPlayButton: CAPlayButton!
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton = PlayButton()
        playButton.frame = CGRect(x: floor((view.bounds.width - 150.0) / 2.0), y: 50.0, width: 150.0, height: 150.0)
        playButton.addTarget(self, action: Selector("playButtonPressed"), forControlEvents: .TouchUpInside)
        view.addSubview(playButton)
        
        caPlayButton = CAPlayButton(frame: CGRect(x: floor((view.bounds.width - 150.0) / 2.0), y: 250.0, width: 150.0, height: 150.0))
        caPlayButton.addTarget(self, action: Selector("caPlayButtonPressed"), forControlEvents: .TouchUpInside)
        view.addSubview(caPlayButton)
    }
    
    // MARK: -
    // MARK: Methods
    
    func playButtonPressed() {
        if playButton.buttonState == .Play {
            playButton.setButtonState(.Pause, animated: true)
        } else if playButton.buttonState == .Pause {
            playButton.setButtonState(.Stop, animated: true)
        } else if playButton.buttonState == .Stop {
            playButton.setButtonState(.Record, animated: true)
        } else if playButton.buttonState == .Record {
            playButton.setButtonState(.Play, animated: true)
        }
    }

    func caPlayButtonPressed() {
        if caPlayButton.buttonState == .Play {
            caPlayButton.setButtonState(.Pause, animated: true)
        } else if caPlayButton.buttonState == .Pause {
            caPlayButton.setButtonState(.Stop, animated: true)
        } else if caPlayButton.buttonState == .Stop {
            caPlayButton.setButtonState(.Record, animated: true)
        } else if caPlayButton.buttonState == .Record {
            caPlayButton.setButtonState(.Play, animated: true)
        }
    }

}

