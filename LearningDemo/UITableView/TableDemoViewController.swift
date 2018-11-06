//
//  TableDemoViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

struct DemoStruct {
    let content: String
    let imageUrl: String?

    init?(dict: [String: Any]) {

        guard let tmpContent = dict["content"] as? String else { return nil }

        content = tmpContent
        imageUrl = dict["imageUrl"] as? String
    }
}

protocol TableDemoViewControllerActionDelegate: class {
    func changeImage(_ image: UIImage?)
    func changeImage(_ urlString: String)
}

class TableDemoViewController: UIViewController {

    private let tableView: UITableView = {
        let tmpView = UITableView(frame: .zero)
        tmpView.translatesAutoresizingMaskIntoConstraints = false
        tmpView.rowHeight = 80
        //tmpView.rowHeight = UITableView.automaticDimension
        //tmpView.estimatedRowHeight = 80
        tmpView.separatorStyle = .none
        return tmpView
    }()

    private var demos: [DemoStruct] = []

    var actionDelegate: TableDemoViewControllerActionDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let getDataBtn: UIButton = {
            let tmpBtn = UIButton(type: .system)
            tmpBtn.translatesAutoresizingMaskIntoConstraints = false
            tmpBtn.setTitle("Get Data", for: .normal)
            tmpBtn.setTitleColor(UIColor.darkGray, for: .normal)
            tmpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            tmpBtn.backgroundColor = UIColor.random
            return tmpBtn
        }()
        getDataBtn.addTarget(self, action: #selector(loadDataSource), for: .touchUpInside)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DemoTableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.addSubview(getDataBtn)
        self.view.addSubview(tableView)


        getDataBtn.snp.setLabel("getDataBtn")
        getDataBtn.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(60)
        }

        tableView.snp.setLabel("tableView")
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(getDataBtn.snp.bottom)
        }

        loadDataSource()
    }

    @objc func loadDataSource() {
        APIService.shared.getDataArray(urlStr: "https://api.mockaroo.com/api/717abe10?count=20&key=06b47d10") { (respArray) in

            guard let tmpArray = respArray else { return }

            for respObj in tmpArray {
                if let dict = respObj as? [String: Any],
                    let demo = DemoStruct(dict: dict) {
                    self.demos.append(demo)
                }
            }

            self.tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDelegate
extension TableDemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) as? DemoTableViewCell {
            //Passing image
            actionDelegate?.changeImage(cell.demoImageView.image)
        }

        if indexPath.row < demos.count {
            let currentDemo = demos[indexPath.row]

            //Passing image url
            if let tmpImageUrl = currentDemo.imageUrl {
                actionDelegate?.changeImage(tmpImageUrl)
            }
        }
    }
}

// MAKR: - UITableViewDataSource
extension TableDemoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DemoTableViewCell

        if indexPath.row < demos.count {
            let currentDemo = demos[indexPath.row]
            cell.titleLabel.text = currentDemo.content
            cell.demoImageView.backgroundColor = .random
            cell.backgroundColor = .random

            if let imgUrl = currentDemo.imageUrl {
                cell.demoImageView.setImage(url: imgUrl)
            }
        }
        return cell
    }
}
