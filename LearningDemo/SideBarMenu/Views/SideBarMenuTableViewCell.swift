//
//  SideBarMenuTableViewCell.swift
//  sample
//
//  Created by Terlun Leung on 5/6/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

class SideBarMenuTableViewCell: UITableViewCell {

    let iconImageViewSize = CGSize(width: 20, height: 20)
    let iconImageView: UIImageView = {
        let tmpImageView = UIImageView()
        tmpImageView.translatesAutoresizingMaskIntoConstraints = false
        tmpImageView.contentMode = .scaleAspectFit
        return tmpImageView
    }()

    let titleLabel: UILabel = {
        let tmpLabel = UILabel()
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpLabel.font = UIFont.systemFont(ofSize: 15)
        tmpLabel.textColor = UIColor.darkText
        tmpLabel.numberOfLines = 0
        tmpLabel.adjustsFontSizeToFitWidth = true
        tmpLabel.minimumScaleFactor = 0.8
        return tmpLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Disable selection style
        self.selectionStyle = .none

        addSubview(iconImageView)
        addSubview(titleLabel)

        iconImageView.snp.setLabel("iconImageView")
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(iconImageViewSize)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }

        titleLabel.snp.setLabel("titleLabel")
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            //make.leading.equalToSuperview().offset(80)
            make.top.greaterThanOrEqualToSuperview().offset(5)
            make.bottom.lessThanOrEqualToSuperview().offset(-5)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        //Reset value before being reused
        titleLabel.text = ""
        iconImageView.image = nil
    }

}
