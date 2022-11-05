//
//  PlayButton.swift
//  DGDrawRectAnimationTutorial
//
//  Created by Danil Gontovnik on 9/24/15.
//  Copyright © 2015 Danil Gontovnik. All rights reserved.
//

import UIKit

enum PlayButtonState {
    case Paused
    case Playing
    
    var value: CGFloat {
        return (self == .Paused) ? 1.0 : 0.0
    }
}

class PlayButton: UIButton {

    // MARK: -
    // MARK: Vars
    
    private(set) var buttonState = PlayButtonState.Paused
    private var animationValue: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: -
    // MARK: Methods
    
    func setButtonState(buttonState: PlayButtonState, animated: Bool) {
        if self.buttonState == buttonState {
            return
        }
        self.buttonState = buttonState
        
        if pop_animation(forKey: "animationValue") != nil {
            pop_removeAnimation(forKey: "animationValue")
        }
        
        let toValue: CGFloat = buttonState.value
        
        if animated {
            let animation: POPBasicAnimation = POPBasicAnimation()

            if let property = POPAnimatableProperty.property(withName: "animationValue",
                                                             initializer: { (prop: POPMutableAnimatableProperty!) -> Void in
                prop.readBlock = { (object: Any?, values: UnsafeMutablePointer<CGFloat>?) -> Void in
                    if let button = object as? PlayButton {
                        values?[0] = button.animationValue
                    }
                }
                prop.writeBlock = { (object: Any?, values: UnsafePointer<CGFloat>?) -> Void in
                    if let button = object as? PlayButton {
                        button.animationValue = values?[0] ?? .zero
                    }
                }
                prop.threshold = 0.01
            }) as? POPAnimatableProperty {
                animation.property = property
            }
            animation.fromValue = NSNumber(value: Float(self.animationValue))
            animation.toValue = NSNumber(value: Float(toValue))
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            animation.duration = 0.25
            pop_add(animation, forKey: "percentage")
        } else {
            animationValue = toValue
        }
    }
    
    // MARK: -
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let height = rect.height
        
        let minWidth = rect.width * 0.32
        let aWidth = (rect.width / 2.0 - minWidth) * animationValue
        let width = minWidth + aWidth
        
        let h1 = height / 4.0 * animationValue
        let h2 = height / 2.0 * animationValue
        
        let context = UIGraphicsGetCurrentContext()

        context?.move(to: CGPoint(x: 0.0, y: 0.0))
        context?.addLine(to: CGPoint(x: width, y: h1))
        context?.addLine(to: CGPoint(x: width, y: height - h1))
        context?.addLine(to: CGPoint(x: 0.0, y: height))

        context?.move(to: CGPoint(x: rect.width - width, y: h1))
        context?.addLine(to: CGPoint(x: rect.width, y: h2))
        context?.addLine(to: CGPoint(x: rect.width, y: height - h2))
        context?.addLine(to: CGPoint(x: rect.width - width, y: height - h1))

        context?.setFillColor(tintColor.cgColor)
        context?.fillPath()
    }
}
