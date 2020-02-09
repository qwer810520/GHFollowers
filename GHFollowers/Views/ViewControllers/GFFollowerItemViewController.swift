//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/9.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }

  // MARK: - Private Methods

  private func configureItems() {
    guard let user = user else { return }
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)

    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }

  // MARK: - Action Methods

  override func actionButtonTapped() {
    guard let user = user else { return }
    delegate?.didTapGetFollowers(for: user)
  }
}
