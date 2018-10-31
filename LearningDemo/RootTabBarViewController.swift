//
//  RootTabBarViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {
    lazy var rootViewController = RootViewController()
    lazy var rootNavigationViewController = UINavigationController(rootViewController: RootViewController())

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rootViewController.title = "Root View Controller"
        rootNavigationViewController.title = "Root Navigation View Controller"

        //        //image size 60x60
        //        rootViewController.tabBarItem.image = UIImage(named: "publication")
        //        rootNavigationViewController.tabBarItem.image = UIImage(named: "people")

        let tabsViewControllers = [rootViewController,
                                   rootNavigationViewController]

        self.viewControllers = tabsViewControllers

    }
}
