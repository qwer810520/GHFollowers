//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/9.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }

  // MARK: - Private Methods

  private func configureItems() {
    guard let user = user else { return }
    itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)

    actionButton.set(backgroundColor: .systemPurple, title: "GitHun Profile")
  }

  // MARK: - Action Methods

  override func actionButtonTapped() {
    guard let user = user else { return }
    delegate?.didTapGitHubProfile(for: user)
  }
}