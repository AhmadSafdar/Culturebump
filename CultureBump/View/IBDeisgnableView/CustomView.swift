//
//  CustomView.swift
//  Quranic
//
//  Created by renameme on 1/28/18.
//  Copyright © 2018 DigicomSolution. All rights reserved.
//

import UIKit

class CustomView: UIView {

    /// The corner radius of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
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
    
    /// The shadow color of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    /// The shadow offset of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    /// The shadow radius of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    /// The shadow opacity of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /**
     Masks the layer to it's bounds and updates the layer properties and shadow path.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        
        self.updateProperties()
        self.updateShadowPath()
    }
    
    /**
     Updates all layer properties according to the public properties of the `ShadowView`.
     */
    fileprivate func updateProperties() {
    }
    
    /**
     Updates the bezier path of the shadow to be the same as the layer's bounds, taking the layer's corner radius into account.
     */
    fileprivate func updateShadowPath() {
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    /**
     Updates the shadow path everytime the views frame changes.
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateShadowPath()
    }

}
