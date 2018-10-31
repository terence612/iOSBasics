//
//  DemoImageView.swift
//  LearningDemo
//
//  Created by Terlun Leung on 31/10/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit
import SDWebImage

class DemoImageView: UIImageView {

    private let sizeToLargeLabel: UILabel = {
        let tmpLabel = UILabel()
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        tmpLabel.font = UIFont.systemFont(ofSize: 14)
        tmpLabel.textColor = UIColor.darkText
        tmpLabel.textAlignment = .center
        tmpLabel.numberOfLines = 0
        tmpLabel.adjustsFontSizeToFitWidth = true
        tmpLabel.text = "0/0"
        tmpLabel.isHidden = true
        return tmpLabel
    }()

    init(){
        super.init(frame: .zero)

        self.addSubview(sizeToLargeLabel)

        sizeToLargeLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(url urlStr: String, defaultImg: UIImage? = nil) {

        guard let validUrl = URL(string: urlStr) else { return }
        self.sd_setImage(with: validUrl,
                         placeholderImage: nil,
                         options: [.scaleDownLargeImages],
                         progress: { (receivedSize, expectedSize, url) in
                            //EGLog("Url \(url?.lastPathComponent) Download Progress: \(receivedSize/expectedSize) %")

                            DispatchQueue.main.async {
                                self.sizeToLargeLabel.isHidden = false
                                self.sizeToLargeLabel.text = "\(Float(receivedSize)/Float(expectedSize))"
                            }

        }){ (image, error, cacheType, url) in
            self.sizeToLargeLabel.isHidden = true
        }
    }
}
