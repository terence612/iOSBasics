//
//  UIColor+Random.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

extension UIColor {
    public class var random: UIColor {
        return UIColor(red: .random(),
                       green: .random(),
                       blue: .random(),
                       alpha: 1.0)
    }
}
