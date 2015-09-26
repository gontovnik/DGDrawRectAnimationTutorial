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
        
        if pop_animationForKey("animationValue") != nil {
            pop_removeAnimationForKey("animationValue")
        }
        
        let toValue: CGFloat = (buttonState == .Paused) ? 1.0 : 0.0
        
        if animated {
            let animation: POPBasicAnimation = POPBasicAnimation()
            if let property = POPAnimatableProperty.propertyWithName("animationValue", initializer: { (prop: POPMutableAnimatableProperty!) -> Void in
                prop.readBlock = { (object: AnyObject!, values: UnsafeMutablePointer<CGFloat>) -> Void in
                    if let button = object as? PlayButton {
                        values[0] = button.animationValue
                    }
                }
                prop.writeBlock = { (object: AnyObject!, values: UnsafePointer<CGFloat>) -> Void in
                    if let button = object as? PlayButton {
                        button.animationValue = values[0]
                    }
                }
                prop.threshold = 0.01
            }) as? POPAnimatableProperty {
                animation.property = property
            }
            animation.fromValue = NSNumber(float: Float(self.animationValue))
            animation.toValue = NSNumber(float: Float(toValue))
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.duration = 0.25
            pop_addAnimation(animation, forKey: "percentage")
        } else {
            animationValue = toValue
        }
    }
    
    // MARK: -
    // MARK: Draw
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let height = rect.height
        
        let minWidth = rect.width * 0.32
        let aWidth = (rect.width / 2.0 - minWidth) * animationValue
        let width = minWidth + aWidth
        
        let h1 = height / 4.0 * animationValue
        let h2 = height / 2.0 * animationValue
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextMoveToPoint(context, 0.0, 0.0)
        CGContextAddLineToPoint(context, width, h1)
        CGContextAddLineToPoint(context, width, height - h1)
        CGContextAddLineToPoint(context, 0.0, height)
        
        CGContextMoveToPoint(context, rect.width - width, h1)
        CGContextAddLineToPoint(context, rect.width, h2)
        CGContextAddLineToPoint(context, rect.width, height - h2)
        CGContextAddLineToPoint(context, rect.width - width, height - h1)
        
        CGContextSetFillColorWithColor(context, tintColor.CGColor)
        CGContextFillPath(context)
    }
    
}
