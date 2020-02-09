//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Min on 2020/2/8.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

struct UIHelper {
  static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minimumItenSpacing: CGFloat = 10
    let availableWidht = width - (padding * 2) - (minimumItenSpacing * 2)
    let itemWidth = availableWidht / 3

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

    return flowLayout
  }
}
