//
//  ContentViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit
import SnapKit

class ContentViewController: UIViewController {

    let titleLabel: UILabel = {
        let tmpLabel = UILabel()
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpLabel.font = UIFont.systemFont(ofSize: 20)
        tmpLabel.textColor = UIColor.darkText
        tmpLabel.textAlignment = .center
        tmpLabel.numberOfLines = 0
        return tmpLabel
    }()

    private let setImageByNotifBtn: UIButton = {
        let tmpBtn = UIButton(type: .system)
        tmpBtn.translatesAutoresizingMaskIntoConstraints = false
        tmpBtn.setTitle("Set Image By Notif", for: .normal)
        tmpBtn.setTitleColor(UIColor.lightText, for: .normal)
        tmpBtn.backgroundColor = UIColor.random
        return tmpBtn
    }()

    private let setImageBySingleton: UIButton = {
        let tmpBtn = UIButton(type: .system)
        tmpBtn.translatesAutoresizingMaskIntoConstraints = false
        tmpBtn.setTitle("Set Image By Singleton", for: .normal)
        tmpBtn.setTitleColor(UIColor.lightText, for: .normal)
        tmpBtn.backgroundColor = UIColor.random
        return tmpBtn
    }()

    private let pushNavigationBtn: UIButton = {
        let tmpBtn = UIButton(type: .system)
        tmpBtn.translatesAutoresizingMaskIntoConstraints = false
        tmpBtn.setTitle("Push view", for: .normal)
        tmpBtn.setTitle("Highlighted", for: .highlighted)
        tmpBtn.setTitleColor(UIColor.lightText, for: .normal)
        tmpBtn.setTitleColor(UIColor.blue, for: .highlighted)
        //tmpBtn.setImage(UIImage(named: "map"), for: .normal)
        tmpBtn.backgroundColor = UIColor.init(red: 0.6, green: 0.5, blue: 0.2, alpha: 1)
        return tmpBtn
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
        view.backgroundColor = UIColor.random
        view.addSubview(titleLabel)

        pushNavigationBtn.addTarget(self,
                                    action: #selector(performPushVC),
                                    for: .touchUpInside)
        setImageByNotifBtn.addTarget(self,
                                     action: #selector(performUpdateImageByNotification),
                                     for: .touchUpInside)
        setImageBySingleton.addTarget(self,
                                      action: #selector(performUpdateImageBySingleton),
                                      for: .touchUpInside)

        view.addSubview(pushNavigationBtn)
        view.addSubview(setImageByNotifBtn)
        view.addSubview(setImageBySingleton)

        titleLabel.snp.setLabel("titleLabel")
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        pushNavigationBtn.snp.setLabel("pushNavigationBtn")
        pushNavigationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            //Constraints conflict
            //make.width.equalTo(100)
            make.height.equalTo(50)
        }

        setImageByNotifBtn.snp.setLabel("setImageBtn")
        setImageByNotifBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pushNavigationBtn.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }

        setImageBySingleton.snp.setLabel("setImageBySingleton")
        setImageBySingleton.snp.makeConstraints { (make) in
            make.top.equalTo(setImageByNotifBtn.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    @objc func performPushVC() {
        let newVC = ContentViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
    }

    @objc func performUpdateImageByNotification() {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "SideBarSetImage"),
                                        object: nil, userInfo: ["image": UIImage(named: "social")!])
    }

    @objc func performUpdateImageBySingleton() {
        SideBarMenuViewController.shared.setHeaderImage(UIImage(named: "video"))
    }
}
