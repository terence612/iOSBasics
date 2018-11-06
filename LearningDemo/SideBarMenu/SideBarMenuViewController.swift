//
//  SideBarMenuViewController.swift
//  sample
//
//  Created by Terlun Leung on 5/6/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit
import SnapKit

protocol SideBarMenuViewControllerDelegate: class {
    func sideBarDidSelected(show website: URL?, title: String?)
}

class SideBarMenuViewController: UIViewController {

    weak var delegate: SideBarMenuViewControllerDelegate?
    static var shared = SideBarMenuViewController()

    private let menuBarCellIdentifier = "menuBarCell"
    private let defaultCellIdentifier = "defaultCell"

    var items: [SideBarMenuItem] = []

    let headerView: SideBarHeaderView = {
        let tmpView = SideBarHeaderView()
        tmpView.translatesAutoresizingMaskIntoConstraints = false
        return tmpView
    }()

    let tableView: UITableView = {
        let tmpTableView = UITableView()
        tmpTableView.translatesAutoresizingMaskIntoConstraints = false
        // Change row height here
        tmpTableView.rowHeight = 40

        // Disable separator style
        tmpTableView.separatorStyle = .none
        return tmpTableView
    }()

    private init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide navigation bar on first page
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        NSLog("sidebar viewDidLoad")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupMenuView()

        loadDataSource()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setImage(notif:)),
                                               name: NSNotification.Name.init(rawValue: "SideBarSetImage"),
                                               object: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: Actions
extension SideBarMenuViewController {
    @objc func didPressedEditButton() {
        //Change Url Here
        let title = "個人訊息"
//        if let apiHost: String = AppConfigHelper.shared.getConfig(field: "apiHost") {
//            let editUrl = URL(string: apiHost + "/profile/")
//            delegate?.sideBarDidSelected(show: editUrl, title: title)
//        }
    }

    @objc func setImage(notif: Notification) {
        if let userInfo = notif.userInfo,
            let image = userInfo["image"] as? UIImage {
            headerView.avatarImageView.image = image
        }
    }

    func setHeaderImage(_ image: UIImage?) {
        headerView.avatarImageView.image = image
    }
}

// MARK: - Data
extension SideBarMenuViewController {
    func loadDataSource() {
        // Fetch from API in here
        let apiHost: String = "https://zh.wikipedia.org/wiki"
            // Fake data
            items = [
                SideBarMenuItem(iconName: "about",
                                title: "佩奇排名",
                                destinationUrl: URL(string: apiHost + "/佩奇排名")),
                SideBarMenuItem(iconName: "admission",
                                title: "墨爾本商學院",
                                destinationUrl: URL(string: apiHost + "/墨爾本商學院")),
                SideBarMenuItem(iconName: "calendar",
                                title: "ETtoday新聞雲",
                                destinationUrl: URL(string: apiHost + "/ETtoday新聞雲")),
                //            SideBarMenuItem(iconName: "imgTestingIcon3",
                //                            title: "說明文件",
                //                            destinationUrl: URL(string: "http://163.21.246.92/doc/userguide.pdf")),
                SideBarMenuItem(iconName: "dining",
                                title: "回首頁",
                                destinationUrl: URL(string: apiHost + ""))
            ]


        //reload tableview wheneven dataset(var items in here) changes
        tableView.reloadData()

        //Update User Info
        headerView.updateData(userName: "Terlun",
                              imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/US_Nickel_2013_Rev.png/190px-US_Nickel_2013_Rev.png")

    }
}

// MARK: - UITableView
extension SideBarMenuViewController {
    func setupMenuView() {

        headerView.settingBtn.addTarget(self, action: #selector(didPressedEditButton), for: .touchUpInside)
        self.view.addSubview(headerView)

        headerView.snp.setLabel("headerView")
        headerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                // Fallback on earlier versions
                make.top.equalToSuperview()
            }
        }

        //Register tableview cell
        tableView.register(SideBarMenuTableViewCell.self,
                           forCellReuseIdentifier: menuBarCellIdentifier)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: defaultCellIdentifier)

        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)

        tableView.snp.setLabel("tableView")
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                // Fallback on earlier versions
                make.bottom.equalToSuperview()
            }
        }

        //Force update view
        self.view.layoutIfNeeded()

    }
}

// MARK: - UITableViewDelegate
extension SideBarMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Selected row at \(indexPath.row)")
        if indexPath.row < items.count {
            delegate?.sideBarDidSelected(show: items[indexPath.row].destinationUrl, title: items[indexPath.row].title)
        }
    }
}

// MARK: - UITableViewDataSource
extension SideBarMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Default cell
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath)

        //Menu bar cell
        if let menuCell = tableView.dequeueReusableCell(withIdentifier: menuBarCellIdentifier, for: indexPath) as? SideBarMenuTableViewCell {

            if indexPath.row < items.count {
                let menuItem = items[indexPath.row]
                // Set title
                menuCell.titleLabel.text = menuItem.title
                // Set image
                menuCell.iconImageView.image = UIImage(named: menuItem.iconName)
            }

            return menuCell
        }

        return defaultCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
