//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    var crTopLeft: Bool {
        get {
            self.layer.maskedCorners.contains(.layerMinXMinYCorner)
        }
        set {
            if newValue {
                self.layer.maskedCorners.insert(.layerMinXMinYCorner)
            } else {
                self.layer.maskedCorners.remove(.layerMinXMinYCorner)
            }
        }
    }
    
    var crTopRight: Bool {
        get {
            self.layer.maskedCorners.contains(.layerMaxXMinYCorner)
        }
        set {
            if newValue {
                self.layer.maskedCorners.insert(.layerMaxXMinYCorner)
            } else {
                self.layer.maskedCorners.remove(.layerMaxXMinYCorner)
            }
        }
    }
    
    var crBottomLeft: Bool {
        get {
            self.layer.maskedCorners.contains(.layerMinXMaxYCorner)
        }
        set {
            if newValue {
                self.layer.maskedCorners.insert(.layerMinXMaxYCorner)
            } else {
                self.layer.maskedCorners.remove(.layerMinXMaxYCorner)
            }
        }
    }
    
    var crBottomRight: Bool {
        get {
            self.layer.maskedCorners.contains(.layerMaxXMaxYCorner)
        }
        set {
            if newValue {
                self.layer.maskedCorners.insert(.layerMaxXMaxYCorner)
            } else {
                self.layer.maskedCorners.remove(.layerMaxXMaxYCorner)
            }
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    func performSpringAnimation(duration: Double, maxScale: CGFloat) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.init(scaleX: maxScale, y: maxScale)
            //reducing the size
            UIView.animate(withDuration: duration, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in

        }
    }
}


