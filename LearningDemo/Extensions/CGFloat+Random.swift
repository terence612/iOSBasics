//
//  CGFloat+Random.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
