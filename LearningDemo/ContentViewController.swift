//
//  ContentViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    let titleLabel: UILabel = {
        let tmpLabel = UILabel()
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpLabel.font = UIFont.systemFont(ofSize: 16)
        tmpLabel.textColor = UIColor.darkText
        tmpLabel.textAlignment = .center
        tmpLabel.numberOfLines = 0
        return tmpLabel
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        NSLog("ContentViewController Init")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .green
    }
}
