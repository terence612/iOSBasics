//
//  RootTabBarViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit
import SideMenu

class RootTabBarViewController: UITabBarController {

    private var menuLeftNavigationController: UISideMenuNavigationController?
    private let sideBarVC = SideBarMenuViewController()

    lazy var rootViewController = RootViewController()
    lazy var tableViewController = TableDemoViewController()
    lazy var webViewController = WebViewController()

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
        tableViewController.title = "TableView"
        rootNavigationViewController.title = "Root Navigation View Controller"
        webViewController.title = "Web View"

        //        //image size 60x60
        //        rootViewController.tabBarItem.image = UIImage(named: "publication")
        //        rootNavigationViewController.tabBarItem.image = UIImage(named: "people")

        tableViewController.actionDelegate = self

        let tabsViewControllers = [tableViewController,
                                   rootNavigationViewController,
                                   webViewController]

        self.viewControllers = tabsViewControllers

        setupSideMenu()
    }

    ///Setup Side Menu Configs
    func setupSideMenu() {

        //Set up delegate for row selection in side menu
        sideBarVC.delegate = self

        // Left Side Navigation
        menuLeftNavigationController = UISideMenuNavigationController(rootViewController: sideBarVC)

        // Present Mode
        SideMenuManager.default.menuPresentMode = .menuSlideIn

        // Set navigation to menu manager
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController!

        // Enable swipe gestures
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view,
                                                                      forMenu: .left)

        // Prevent status bar background color change to black after side menu is shown
        SideMenuManager.default.menuAnimationBackgroundColor = .white

        // Change menu width
        // Prevent iPad showing half width side menu
        let menuWidth = min(UIScreen.main.bounds.width * 0.5, 250)
        SideMenuManager.default.menuWidth = menuWidth

        // Other animation duration settings
        SideMenuManager.default.menuAnimationPresentDuration = 0.25
        SideMenuManager.default.menuAnimationDismissDuration = 0.25
        SideMenuManager.default.menuAnimationCompleteGestureDuration = 0.25
    }
}

// MARK: - SideBarMenuViewControllerDelegate
extension RootTabBarViewController: SideBarMenuViewControllerDelegate {
    func sideBarDidSelected(show website: URL?, title: String?) {
        NSLog("sideBarDidSelected")
    }
}


// MARK: - TableDemoViewControllerActionDelegate
extension RootTabBarViewController: TableDemoViewControllerActionDelegate {
    func changeImage(_ urlString: String) {
        sideBarVC.headerView.avatarImageView.setImage(url: urlString)
    }

    func changeImage(_ image: UIImage?) {
        sideBarVC.headerView.avatarImageView.image = image
    }

}
