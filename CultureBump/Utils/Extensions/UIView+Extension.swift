//
//  UIView+Extension.swift
//  Quranic
//
//  Created by renameme on 4/7/18.
//  Copyright © 2018 TodayPublication. All rights reserved.
//

import UIKit

/// Animations completion block
public typealias CompletionBlock = (()->())

// MARK: - UIView extension with animations.
public extension UIView {
    


    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
