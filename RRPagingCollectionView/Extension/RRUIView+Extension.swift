//
//  RRUIView+Extension.swift
//  RRPagingCollectionView
//
//  Created by Rahul Mayani on 31/07/20.
//  Copyright © 2020 RR. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: Set & Get Frame
    
    /**
     Get Set x Position
     
     - parameter x: CGFloat
     by DaRk-_-D0G
     */
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    /**
     Get Set y Position
     
     - parameter y: CGFloat
     by DaRk-_-D0G
     */
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    /**
     Get Set Height
     
     - parameter height: CGFloat
     by DaRk-_-D0G
     */
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    /**
     Get Set Width
     
     - parameter width: CGFloat
     by DaRk-_-D0G
     */
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    // MARK: top, right, bottom, left, center x&y and size|origin
    
    public var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    public var right: CGFloat {
        get { return self.frame.origin.x + self.width }
        set { self.frame.origin.x = newValue - self.width }
    }
    public var bottom: CGFloat {
        get { return self.frame.origin.y + self.height }
        set { self.frame.origin.y = newValue - self.height }
    }
    public var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    public var centerX: CGFloat{
        get { return self.center.x }
        set { self.center = CGPoint(x: newValue,y: self.centerY) }
    }
    public var centerY: CGFloat {
        get { return self.center.y }
        set { self.center = CGPoint(x: self.centerX,y: newValue) }
    }
    
    public var origin: CGPoint {
        set { self.frame.origin = newValue }
        get { return self.frame.origin }
    }
    public var size: CGSize {
        set { self.frame.size = newValue }
        get { return self.frame.size }
    }
    
    // MARK: - Others -
    
    public class func fromNib(_ nibNameOrNil:String) ->  UIView {
        return  Bundle.main.loadNibNamed(nibNameOrNil, owner: self, options: nil)!.first as! UIView
    }
    public func makeRound(borderWidth: CGFloat = 1, borderColor: UIColor){
        self.layer.cornerRadius  = self.layer.frame.height / 2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func bottomLine(color: UIColor = .white) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(0, height - 1, width, 1)
        bottomLine.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    // MARK: - IBInspectable -
    @IBInspectable public var viewCornerRadius: CGFloat {
        get { return self.viewCornerRadius }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.flatMap { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    // MARK: - Animation -
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: "transform.rotation")
    }

    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x + 20.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x , y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func blink(_ repeatCount: Float = 3) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.isRemovedOnCompletion = false
        animation.fromValue           = 1
        animation.toValue             = 0
        animation.duration            = 1
        animation.autoreverses        = true
        animation.repeatCount         = repeatCount
        animation.beginTime           = CACurrentMediaTime() + 0.5
        self.layer.add(animation, forKey: "opacity")
    }
    
    func setAnimationType(type : String) {
        
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.duration = 0.4
        transition.subtype = CATransitionSubtype(rawValue: type) //kCATransitionFromTop
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.layer.add(transition, forKey: "SwitchToView1")
    }
}

// MARK: - Animate View
extension UIView {

    // Will take screen shot of whole screen and return image. It's working on main thread and may lag UI.
    func takeScreenShot() -> UIImage {
        UIGraphicsBeginImageContext(bounds.size)
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        let rec = bounds
        drawHierarchy(in: rec, afterScreenUpdates: true)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }

    func inAnimate() {
        self.alpha = 1.0
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [0.01, 0.6, 1]
        animation.keyTimes = [0, 0.3, 0.5]
        animation.duration = 0.5
        self.layer.add(animation, forKey: "bounce")
    }

    func outAnimation(comp: @escaping ((Bool) -> Void)) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            comp(true)
        })

        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1, 0.6, 0.01]
        animation.keyTimes = [0, 0.3, 0.5]
        animation.duration = 0.2
        self.layer.add(animation, forKey: "bounce")
        CATransaction.commit()
    }
    
    func blinkAnimation(_ repeatCount: Float = 1000000000) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.isRemovedOnCompletion = false
        animation.fromValue           = 1
        animation.toValue             = 0
        animation.duration            = 0.7
        animation.autoreverses        = true
        animation.repeatCount         = repeatCount
        animation.beginTime           = CACurrentMediaTime() + 0.5
        self.layer.add(animation, forKey: "opacity")
    }
}
