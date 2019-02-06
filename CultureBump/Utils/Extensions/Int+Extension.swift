//
//  String+Extension.swift
//  Quranic
//
//  Created by renameme on 2/2/18.
//  Copyright © 2018 TodayPublication. All rights reserved.
//

import UIKit

extension Int
{

    static func randomNumber<T : SignedInteger>(inRange range: ClosedRange<T>) -> T {
        let length = Int64(range.upperBound - range.lowerBound + 1)
        let value = Int64(arc4random()) % length + Int64(range.lowerBound)
        return T(value)
    }
}

extension Float {
    func roundToInt() -> Int {
        if self.isNaN || self.isInfinite {
            return 0
        }
        let value = Int(self)
        let f = self - Float(value)
        if f < 0.5{
            return value
        } else {
            return value + 1
        }
    }
}

