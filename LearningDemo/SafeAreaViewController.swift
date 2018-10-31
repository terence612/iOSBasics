//
//  SafeAreaViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit
import SnapKit

class SafeAreaViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .random

        let backButton: UIButton = {
            let tmpBtn = UIButton(type: .system)
            tmpBtn.translatesAutoresizingMaskIntoConstraints = false
            tmpBtn.setTitle("Back to previous page", for: .normal)
            tmpBtn.setTitleColor(UIColor.darkText, for: .normal)
            tmpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            tmpBtn.backgroundColor = .random
            return tmpBtn
        }()

        let topSafeAreaView = setupTopBaseView()
        let bottomSafeAreaView = setupBottomBaseView()

        backButton.addTarget(self, action: #selector(performBack), for: .touchUpInside)
        view.addSubview(backButton)
        view.addSubview(topSafeAreaView)
        view.addSubview(bottomSafeAreaView)

        backButton.snp.setLabel("backButton")
        backButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.center.equalToSuperview()
        }

        topSafeAreaView.snp.setLabel("topSafeAreaView")
        topSafeAreaView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
        }

        bottomSafeAreaView.snp.setLabel("bottomSafeAreaView")
        bottomSafeAreaView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupTopBaseView() -> UIView {
        let baseView: UIView = {
            let tmpView = UIView()
            tmpView.backgroundColor = .red
            tmpView.translatesAutoresizingMaskIntoConstraints = false
            return tmpView
        }()

        let topSafeAreaView = setupSafeAreaView(title: "TOP SAFE AREA")

        baseView.addSubview(topSafeAreaView)

        topSafeAreaView.snp.setLabel("topSafeAreaView")
        topSafeAreaView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(baseView.safeAreaLayoutGuide.snp.topMargin)
            } else {
                // Fallback on earlier versions
                make.top.equalToSuperview()
            }

            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        return baseView
    }

    func setupBottomBaseView() -> UIView {
        let baseView: UIView = {
            let tmpView = UIView()
            tmpView.backgroundColor = .red
            tmpView.translatesAutoresizingMaskIntoConstraints = false
            return tmpView
        }()

        let bottomSafeAreaView = setupSafeAreaView(title: "BOTTOM SAFE AREA")
        baseView.addSubview(bottomSafeAreaView)

        bottomSafeAreaView.snp.setLabel("bottomSafeAreaView")
        bottomSafeAreaView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(baseView.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                // Fallback on earlier versions
                make.bottom.equalToSuperview()
            }

            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        return baseView
    }

    func setupSafeAreaView(title: String) -> UIView {
        let baseView: UIView = {
            let tmpView = UIView()
            tmpView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 141/255, alpha: 1)
            tmpView.translatesAutoresizingMaskIntoConstraints = false
            return tmpView
        }()

        let titleLabel: UILabel = {
            let tmpLabel = UILabel()
            tmpLabel.translatesAutoresizingMaskIntoConstraints = false
            tmpLabel.font = UIFont.systemFont(ofSize: 20)
            tmpLabel.textColor = UIColor.darkText
            //tmpLabel.backgroundColor = UIColor.random
            tmpLabel.textAlignment = .center
            tmpLabel.text = title
            return tmpLabel
        }()

        baseView.addSubview(titleLabel)

        titleLabel.snp.setLabel("titleLabel")
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        return baseView
    }

    @objc func performBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
