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

    let safeAreaBtn: UIButton = {
        let tmpBtn = UIButton(type: .system)
        tmpBtn.translatesAutoresizingMaskIntoConstraints = false
        tmpBtn.setTitle("Safe Area VC", for: .normal)
        tmpBtn.backgroundColor = .random
        return tmpBtn
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //You can try to put this in viewWillAppear to see the difference
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(red: 178/255, green: 235/255, blue: 242/255, alpha: 1)

        pushNavigationBtn.addTarget(
            self,
            action: #selector(performPushNavigation(sender:)),
            for: .touchUpInside
        )

        safeAreaBtn.addTarget(
            self,
            action: #selector(performPushSaveVC),
            for: .touchUpInside
        )

        view.addSubview(pushNavigationBtn)

        view.addSubview(safeAreaBtn)


        pushNavigationBtn.snp.setLabel("pushNavigationBtn")
        pushNavigationBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            //make.bottom.equalTo(safeAreaBtn.snp.top).offset(20)
            //make.bottom.equalTo(safeAreaBtn.snp.top).offset(-20)
        }

        safeAreaBtn.snp.setLabel("safeAreaBtn")
        safeAreaBtn.snp.makeConstraints { (make) in
            //make.top.equalTo(pushNavigationBtn).offset(20)
            make.top.equalTo(pushNavigationBtn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    @objc func performPushNavigation(sender: UIButton) {
        print(sender)
        performPushNavigation()
    }

    @objc func performPushNavigation() {
        let contentView = ContentViewController()
        contentView.titleLabel.text = "Content View"
        self.navigationController?.pushViewController(contentView, animated: true)
    }

    @objc func performPushSaveVC() {
        let safeAreaVC = SafeAreaViewController()
        self.navigationController?.pushViewController(safeAreaVC, animated: true)
    }
}
