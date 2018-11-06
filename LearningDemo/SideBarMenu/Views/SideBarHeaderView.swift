//
//  SideBarHeaderView.swift
//  sample
//
//  Created by Terlun Leung on 6/6/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

class SideBarHeaderView: UIView {

    let settingBtn: UIButton = {
        let tmpBtn = UIButton(frame: .zero)
        tmpBtn.translatesAutoresizingMaskIntoConstraints = false
        tmpBtn.setImage(nil, for: .normal)
        tmpBtn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return tmpBtn
    }()

    let nameLabel: UILabel = {
        let tmpLabel = UILabel()
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpLabel.font = UIFont.systemFont(ofSize: 18)
        tmpLabel.textColor = UIColor.darkText
        tmpLabel.numberOfLines = 0
        return tmpLabel
    }()

    let avatarImageSize = CGSize(width: 80, height: 80)
    let avatarImageView: DemoImageView = {
        let tmpImageView = DemoImageView()
        tmpImageView.translatesAutoresizingMaskIntoConstraints = false
        tmpImageView.layer.masksToBounds = true
        return tmpImageView
    }()

    init() {
        super.init(frame: .zero)

        avatarImageView.layer.cornerRadius = avatarImageSize.width / 2
        addSubview(avatarImageView)
        addSubview(settingBtn)
        addSubview(nameLabel)

        avatarImageView.snp.setLabel("avatarImageView")
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(avatarImageSize)
        }

        nameLabel.snp.setLabel("nameLabel")
        nameLabel.snp.makeConstraints { (make) in
            make.leading.greaterThanOrEqualToSuperview().offset(15)
            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }

        settingBtn.snp.setLabel("settingBtn")
        settingBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
            make.centerY.equalTo(nameLabel)
            //Button size
            make.width.height.equalTo(30)
        }
    }

    func updateData(userName: String, imageUrl: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = userName
            self.avatarImageView.setImage(url: imageUrl, defaultImg: #imageLiteral(resourceName: "people"))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
