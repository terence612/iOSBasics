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
        contentView.title = "Push from Root View Controller"
        contentView.titleLabel.text = "Push from Root View Controller"
        self.navigationController?.pushViewController(contentView, animated: true)
    }
}
