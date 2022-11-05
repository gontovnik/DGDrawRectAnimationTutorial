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
        
        leftHalfLayer.fillColor = self.tintColor.cgColor
        leftHalfLayer.path = leftHalfPathForState(buttonState: buttonState)
        layer.addSublayer(leftHalfLayer)
        
        rightHalfLayer.fillColor = self.tintColor.cgColor
        rightHalfLayer.path = rightHalfPathForState(buttonState: buttonState)
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
            if let presentationLayer = leftHalfLayer.presentation() {
                leftHalfAnimation.fromValue = presentationLayer.path
            } else {
                leftHalfAnimation.fromValue = leftHalfLayer.path
            }
            leftHalfAnimation.toValue = leftHalfPathForState(buttonState: buttonState)
            leftHalfAnimation.duration = 0.25
            leftHalfAnimation.fillMode = CAMediaTimingFillMode.forwards
            leftHalfAnimation.isRemovedOnCompletion = false
            leftHalfAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            leftHalfLayer.add(leftHalfAnimation, forKey: "kPathAnimation")
            
            let rightHalfAnimation = CABasicAnimation(keyPath: "path")
            if let presentationLayer = rightHalfLayer.presentation() {
                rightHalfAnimation.fromValue = presentationLayer.path
            } else {
                rightHalfAnimation.fromValue = rightHalfLayer.path
            }
            rightHalfAnimation.toValue = rightHalfPathForState(buttonState: buttonState)
            rightHalfAnimation.duration = 0.25
            rightHalfAnimation.fillMode = CAMediaTimingFillMode.forwards
            rightHalfAnimation.isRemovedOnCompletion = false
            rightHalfAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            rightHalfLayer.add(rightHalfAnimation, forKey: "kPathAnimation")
        } else {
            leftHalfLayer.removeAllAnimations()
            rightHalfLayer.removeAllAnimations()
            
            leftHalfLayer.path = leftHalfPathForState(buttonState: buttonState)
            rightHalfLayer.path = rightHalfPathForState(buttonState: buttonState)
        }
    }
    
    // MARK: -
    // MARK: Getters
    
    private func leftHalfPathForState(buttonState: CAPlayButtonState) -> CGPath {
        let bezierPath = UIBezierPath()
        
        let width = leftHalfLayer.bounds.width
        let height = leftHalfLayer.bounds.height
        
        if buttonState == .Paused {
            bezierPath.move(to: CGPoint(x: 0.0, y: 0.0))
            bezierPath.addLine(to: CGPoint(x: 0.0, y: height))
            bezierPath.addLine(to: CGPoint(x: width, y: height / 4.0 * 3.0))
            bezierPath.addLine(to: CGPoint(x: width, y: height / 4.0))
        } else {
            bezierPath.move(to: CGPoint(x: 0.0, y: 0.0))
            bezierPath.addLine(to: CGPoint(x: 0.0, y: height))
            bezierPath.addLine(to: CGPoint(x: width * 0.64, y: height))
            bezierPath.addLine(to: CGPoint(x: width * 0.64, y: 0.0))
        }
        
        bezierPath.close()
        
        return bezierPath.cgPath;
    }
    
    private func rightHalfPathForState(buttonState: CAPlayButtonState) -> CGPath {
        let bezierPath = UIBezierPath()
        
        let width = rightHalfLayer.bounds.width
        let height = rightHalfLayer.bounds.height
        
        if buttonState == .Paused {
            bezierPath.move(to: CGPoint(x: 0.0, y: height / 4.0))
            bezierPath.addLine(to: CGPoint(x: 0.0, y: height / 4.0 * 3.0))
            bezierPath.addLine(to: CGPoint(x: width, y: height / 2.0))
            bezierPath.addLine(to: CGPoint(x: width, y: height / 2.0))
        } else {
            bezierPath.move(to: CGPoint(x: width * 0.36, y: 0.0))
            bezierPath.addLine(to: CGPoint(x: width * 0.36, y: height))
            bezierPath.addLine(to: CGPoint(x: width, y: height))
            bezierPath.addLine(to: CGPoint(x: width, y: 0.0))
        }
        
        bezierPath.close()
        
        return bezierPath.cgPath;
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
