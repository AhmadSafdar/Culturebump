//
//  String+Extension.swift
//  Quranic
//
//  Created by renameme on 2/2/18.
//  Copyright © 2018 TodayPublication. All rights reserved.
//

import UIKit

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
