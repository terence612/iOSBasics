//
//  DemoTableViewCell.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit
import SnapKit

class DemoTableViewCell: UITableViewCell {

    let demoImageView: DemoImageView = {
        let tmpView = DemoImageView()
        tmpView.translatesAutoresizingMaskIntoConstraints = false
        tmpView.contentMode = .scaleAspectFill
        tmpView.layer.cornerRadius = 15
        //Try to comment this line
        tmpView.layer.masksToBounds = true
        return tmpView
    }()

    let titleLabel: UILabel = {
        let tmpLabel = UILabel()
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpLabel.font = UIFont.systemFont(ofSize: 14)
        tmpLabel.numberOfLines = 0
        tmpLabel.adjustsFontSizeToFitWidth = true
        tmpLabel.minimumScaleFactor = 0.9
        return tmpLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubview(demoImageView)
        addSubview(titleLabel)

        demoImageView.snp.setLabel("demoImageView")
        demoImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }

        titleLabel.snp.setLabel("titleLabel")
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(demoImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        demoImageView.sd_cancelCurrentImageLoad()
        demoImageView.image = nil
        titleLabel.text = ""
    }

}
