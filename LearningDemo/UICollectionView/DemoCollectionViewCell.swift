//
//  DemoCollectionViewCell.swift
//  LearningDemo
//
//  Created by Terlun Leung on 7/11/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

class DemoCollectionViewCell: UICollectionViewCell {

    let iconImageView: UIImageView = {
        let tmpImageView = UIImageView()
        tmpImageView.translatesAutoresizingMaskIntoConstraints = false
        tmpImageView.contentMode = .scaleAspectFit
        return tmpImageView
    }()

    let titleLabel: UILabel = {
        let tmpLabel = UILabel()
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpLabel.font = UIFont.systemFont(ofSize: 18)
        tmpLabel.textColor = UIColor.darkText
        tmpLabel.textAlignment = .center
        tmpLabel.numberOfLines = 0
        return tmpLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)

        iconImageView.snp.setLabel("iconImageView")
        iconImageView.snp.makeConstraints { (make) in
            make.size.width.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }

        titleLabel.snp.setLabel("titleLabel")
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
