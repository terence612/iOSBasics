//
//  DemoCollectionViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 7/11/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit

class DemoCollectionViewController: UICollectionViewController {

    let cellMinimumLineSpacing: CGFloat = 1
    let cellMinimumInteritemSpacing: CGFloat = 1
    let viewEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
    var numOfCellInOneRow: Int = 4

    // MARK: - Private
    private let vcTitle: String

    init(name: String = "No Name") {
        self.vcTitle = name
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCollectionView()
    }

    func setupCollectionView() {

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            //flowLayout.scrollDirection = .horizontal
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = cellMinimumLineSpacing
            flowLayout.minimumInteritemSpacing = cellMinimumInteritemSpacing
            flowLayout.sectionInset = viewEdgeInsets
        }

        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(DemoCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        //collectionView?.isPagingEnabled = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                      for: indexPath) as! DemoCollectionViewCell
        let types: [String] = ["video",
                               "transit",
                               "social",
                               "news",
                               "map",
                               "login",
                               "links",
                               "people"]

        if let type = types.randomElement() {
            cell.iconImageView.image = UIImage(named: type)
            cell.titleLabel.text = type
        }

        cell.backgroundColor = .random
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("didSelectCell(indexPath: IndexPath) \(indexPath)")
    }

    func cellSize(width: CGFloat, height: CGFloat? = nil) -> CGSize {
        if let tmpH = height {
            return CGSize(width: width, height: tmpH)
        }
        return CGSize(width: width, height: width)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension DemoCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        //        if #available(iOS 11.0, *) {
        //                    return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.size.width,
        //                                  height: view.safeAreaLayoutGuide.layoutFrame.size.height)
        //        }

        //        return CGSize(width: view.frame.width, height: view.frame.height)

        let widthWithInset = (collectionView.frame.width -
            (viewEdgeInsets.left + viewEdgeInsets.right)) / CGFloat(numOfCellInOneRow)

        return cellSize(width: widthWithInset - cellMinimumInteritemSpacing)

        //        return CGSize(width: ,
        //                      height: collectionView.frame.width / 2 - 1)
    }
}
