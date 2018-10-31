//
//  TableDemoViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

class TableDemoViewController: UIViewController {

    private let tableView: UITableView = {
        let tmpView = UITableView(frame: .zero)
        tmpView.translatesAutoresizingMaskIntoConstraints = false
        //tmpView.separatorStyle = .none
        return tmpView
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DemoTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        self.view.addSubview(tableView)

        tableView.snp.setLabel("tableView")
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    func loadDatasource() {

    }
}


// MARK: - UITableViewDelegate
extension TableDemoViewController: UITableViewDelegate {

}

// MAKR: - UITableViewDataSource
extension TableDemoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DemoTableViewCell
        cell.titleLabel.text = ""
        cell.demoImageView.backgroundColor = .random
        cell.backgroundColor = .random
        //cell.demoImageView.setImage(url: "")
        return cell
    }
}
