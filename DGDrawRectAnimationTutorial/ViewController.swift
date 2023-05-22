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
        playButton.frame = CGRect(x: floor((view.bounds.width - 150.0) / 2.0),
                                  y: 50.0, width: 150.0, height: 150.0)
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        view.addSubview(playButton)
        
        caPlayButton = CAPlayButton(frame: CGRect(x: floor((view.bounds.width - 150.0) / 2.0),
                                                  y: 250.0, width: 150.0, height: 150.0))
        caPlayButton.addTarget(self, action: #selector(caPlayButtonPressed), for: .touchUpInside)
        view.addSubview(caPlayButton)
    }
    
    // MARK: -
    // MARK: Methods
    
    @objc func playButtonPressed() {
        if playButton.buttonState == .Playing {
            playButton.setButtonState(buttonState: .Paused, animated: true)
        } else {
            playButton.setButtonState(buttonState: .Playing, animated: true)
        }
    }

    @objc func caPlayButtonPressed() {
        if caPlayButton.buttonState == .Playing {
            caPlayButton.setButtonState(buttonState: .Paused, animated: true)
        } else {
            caPlayButton.setButtonState(buttonState: .Playing, animated: true)
        }
    }
}
