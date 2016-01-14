//
//  CAPlayButton.swift
//  DGDrawRectAnimationTutorial
//
//  Created by Danil Gontovnik on 9/25/15.
//  Copyright © 2015 Danil Gontovnik. All rights reserved.
//

enum CAPlayButtonState {
    case Pause
    case Play
    case Stop
    case Record
}

class CAPlayButton: UIButton {
    
    // MARK: -
    // MARK: Vars
    
    private(set) var buttonState = CAPlayButtonState.Pause
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
        
        self.layer.masksToBounds = true
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
            print("animated")
            let squareAnimation = CABasicAnimation(keyPath: "cornerRadius");
            
            // roundfy for record
            if self.buttonState == .Record {
                squareAnimation.fromValue = 0.0
                squareAnimation.toValue = self.frame.width/2.0
                squareAnimation.duration = 0.25
                squareAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                squareAnimation.fillMode = kCAFillModeForwards
                squareAnimation.removedOnCompletion = false
                self.layer.addAnimation(squareAnimation, forKey: "cornerRadius")
                self.layer.cornerRadius = self.frame.width/2.0
            } else {
                squareAnimation.fromValue = self.layer.cornerRadius
                squareAnimation.toValue = 0.0
                squareAnimation.duration = 0.25
                squareAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                squareAnimation.fillMode = kCAFillModeForwards
                squareAnimation.removedOnCompletion = false
                self.layer.addAnimation(squareAnimation, forKey: "cornerRadius")
                self.layer.cornerRadius = 0.0
            }
            
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
        
        let width = leftHalfLayer.bounds.width+1
        let height = leftHalfLayer.bounds.height
        
        if buttonState == .Play {
            bezierPath.moveToPoint(CGPoint(x: width, y: height / 4.0))
            bezierPath.addLineToPoint(CGPoint(x: 0.0, y: 0.0))
            bezierPath.addLineToPoint(CGPoint(x: 0.0, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height / 4.0 * 3.0))
        } else if buttonState == .Pause {
            bezierPath.moveToPoint(CGPoint(x: width * 0.64, y: 0.0))
            bezierPath.addLineToPoint(CGPoint(x: 0.0, y: 0.0))
            bezierPath.addLineToPoint(CGPoint(x: 0.0, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width * 0.64, y: height))
        } else {
            bezierPath.moveToPoint(CGPoint(x:width, y:0))
            bezierPath.addLineToPoint(CGPoint(x:0.0, y:0.0))
            bezierPath.addLineToPoint(CGPoint(x: 0, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height))
        }
        
        bezierPath.closePath()
        
        return bezierPath.CGPath;
    }
    
    private func rightHalfPathForState(buttonState: CAPlayButtonState) -> CGPathRef {
        let bezierPath = UIBezierPath()
        
        let width = rightHalfLayer.bounds.width
        let height = rightHalfLayer.bounds.height
        
        if buttonState == .Play {
            bezierPath.moveToPoint(CGPoint(x: 0.0, y: height / 4.0))
            bezierPath.addLineToPoint(CGPoint(x: 0.0, y: height / 4.0 * 3.0))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height / 2.0))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height / 2.0))
        } else if buttonState == .Pause {
            bezierPath.moveToPoint(CGPoint(x: width * 0.36, y: 0.0))
            bezierPath.addLineToPoint(CGPoint(x: width * 0.36, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width, y: 0.0))
        } else {
            bezierPath.moveToPoint(CGPoint(x:0.0, y:0.0))
            bezierPath.addLineToPoint(CGPoint(x: 0, y: height))
            bezierPath.addLineToPoint(CGPoint(x: width, y: height))
            bezierPath.addLineToPoint(CGPoint(x:width, y:0))
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
