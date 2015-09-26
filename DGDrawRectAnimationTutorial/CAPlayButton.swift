//
//  CAPlayButton.swift
//  DGDrawRectAnimationTutorial
//
//  Created by Danil Gontovnik on 9/25/15.
//  Copyright © 2015 Danil Gontovnik. All rights reserved.
//

enum CAPlayButtonState {
    case Paused
    case Playing
}

class CAPlayButton: UIButton {
    
    // MARK: -
    // MARK: Vars
    
    private(set) var buttonState = CAPlayButtonState.Paused
    private var leftHalfLayer = CAShapeLayer()
    private var rightHalfLayer = CAShapeLayer()
    
    // MARK: -
    // MARK: Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutSubviews()
        
        leftHalfLayer.fillColor = self.tintColor.CGColor
        leftHalfLayer.path = leftHalfPathForState(buttonState)
        layer.addSublayer(leftHalfLayer)
        
        rightHalfLayer.fillColor = self.tintColor.CGColor
        rightHalfLayer.path = rightHalfPathForState(buttonState)
        layer.addSublayer(rightHalfLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -
    // MARK: Methods
    
    func setButtonState(buttonState: CAPlayButtonState, animated: Bool) {
        if self.buttonState == buttonState {
            return
        }
        self.buttonState = buttonState
        
        if animated {
            let leftHalfAnimation = CABasicAnimation(keyPath: "path")
            if let presentationLayer = leftHalfLayer.presentationLayer() as? CAShapeLayer {
                leftHalfAnimation.fromValue = presentationLayer.path
            } else {
                leftHalfAnimation.fromValue = leftHalfLayer.path
            }
            leftHalfAnimation.toValue = leftHalfPathForState(buttonState)
            leftHalfAnimation.duration = 0.25
            leftHalfAnimation.fillMode = kCAFillModeForwards
            leftHalfAnimation.removedOnCompletion = false
            leftHalfAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            leftHalfLayer.addAnimation(leftHalfAnimation, forKey: "kPathAnimation")
            
            let rightHalfAnimation = CABasicAnimation(keyPath: "path")
            if let presentationLayer = rightHalfLayer.presentationLayer() as? CAShapeLayer {
                rightHalfAnimation.fromValue = presentationLayer.path
            } else {
                rightHalfAnimation.fromValue = rightHalfLayer.path
            }
            rightHalfAnimation.toValue = rightHalfPathForState(buttonState)
            rightHalfAnimation.duration = 0.25
            rightHalfAnimation.fillMode = kCAFillModeForwards
            rightHalfAnimation.removedOnCompletion = false
            rightHalfAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            rightHalfLayer.addAnimation(rightHalfAnimation, forKey: "kPathAnimation")
        } else {
            leftHalfLayer.removeAllAnimations()
            rightHalfLayer.removeAllAnimations()
            
            leftHalfLayer.path = leftHalfPathForState(buttonState)
            rightHalfLayer.path = rightHalfPathForState(buttonState)
        }
    }
    
    // MARK: -
    // MARK: Getters
    
    private func leftHalfPathForState(buttonState: CAPlayButtonState) -> CGPathRef {
        let bezierPath = UIBezierPath()
        
        let width = leftHalfLayer.bounds.width
        let height = leftHalfLayer.bounds.height
        
        if buttonState == .Paused {
            bezierPath.moveToPoint(CGPoint(x: 0.0, y: 0.0))
            bezierPath.addLineToPoint(CGPoint(x: 0.0, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height / 4.0 * 3.0))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height / 4.0))
        } else {
            bezierPath.moveToPoint(CGPoint(x: 0.0, y: 0.0))
            bezierPath.addLineToPoint(CGPoint(x: 0.0, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width * 0.64, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width * 0.64, y: 0.0))
        }
        
        bezierPath.closePath()
        
        return bezierPath.CGPath;
    }
    
    private func rightHalfPathForState(buttonState: CAPlayButtonState) -> CGPathRef {
        let bezierPath = UIBezierPath()
        
        let width = rightHalfLayer.bounds.width
        let height = rightHalfLayer.bounds.height
        
        if buttonState == .Paused {
            bezierPath.moveToPoint(CGPoint(x: 0.0, y: height / 4.0))
            bezierPath.addLineToPoint(CGPoint(x: 0.0, y: height / 4.0 * 3.0))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height / 2.0))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height / 2.0))
        } else {
            bezierPath.moveToPoint(CGPoint(x: width * 0.36, y: 0.0))
            bezierPath.addLineToPoint(CGPoint(x: width * 0.36, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width, y: 0.0))
        }
        
        bezierPath.closePath()
        
        return bezierPath.CGPath;
    }
    
    // MARK: -
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = bounds.width
        let height = bounds.height
        
        leftHalfLayer.frame = CGRect(x: 0.0, y: 0.0, width: width / 2.0, height: height)
        rightHalfLayer.frame = CGRect(x: width / 2.0, y: 0.0, width: width / 2.0, height: height)
    }

}
