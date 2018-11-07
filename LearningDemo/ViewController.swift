//
//  ViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.backgroundColor = .random
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentView = setupContentView()
        scrollView.addSubview(contentView)

        contentView.snp.setLabel("contentView")
        contentView.snp.makeConstraints { (make) in
            make.leading.top.bottom.trailing.equalToSuperview()
        }

        scrollView.snp.setLabel("scrollView")
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func setupContentView() -> UIView {
        let baseView: UIView = {
            let tmpView = UIView()
            tmpView.backgroundColor = .random
            tmpView.translatesAutoresizingMaskIntoConstraints = false
            return tmpView
        }()

        let redView: UIView = {
            let tmpView = UIView()
            tmpView.backgroundColor = .red
            tmpView.translatesAutoresizingMaskIntoConstraints = false
            return tmpView
        }()

        baseView.addSubview(redView)

        redView.snp.setLabel("redView")
        redView.snp.makeConstraints { (make) in
            make.height.equalTo(1000)
            make.width.equalTo(1000)
            make.edges.equalToSuperview()
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.centerX.equalToSuperview()
        }

        return baseView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

