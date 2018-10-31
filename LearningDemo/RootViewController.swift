//
//  RootViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit
import SnapKit

class RootViewController: UIViewController {

    let pushNavigationBtn: UIButton = {
        let tmpBtn = UIButton()
        tmpBtn.translatesAutoresizingMaskIntoConstraints = false
        tmpBtn.setTitle("Push view", for: .normal)
        tmpBtn.backgroundColor = UIColor.init(red: 0.1, green: 0.7, blue: 0.4, alpha: 1)
        return tmpBtn
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        view.addSubview(pushNavigationBtn)

        pushNavigationBtn.addTarget(self, action: #selector(performPushNavigation(sender:)), for: .touchUpInside)
        pushNavigationBtn.snp.setLabel("pushNavigationBtn")
        pushNavigationBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    @objc func performPushNavigation(sender: UIButton) {
        print(sender)
        performPushNavigation()
    }

    @objc func performPushNavigation() {
        let contentView = ContentViewController()
        contentView.titleLabel.text = "Content View"

        //Method 1, guard let
//        guard let navVC = self.navigationController else {
//            NSLog("Does not have navigation controller")
//            return
//        }
//        navVC.pushViewController(contentView, animated: true)

        //Method 2, if let
//        if let navVC = self.navigationController {
//            navVC.pushViewController(contentView, animated: true)
//        }

        //Method 3, force casting
//        if self.navigationController != nil {
//            //Not recommeded
//            self.navigationController!.pushViewController(contentView,
//                                                          animated: true)
//        }

        //Method 4, optional
        self.navigationController?.pushViewController(contentView,
                                                      animated: true)
    }
}
