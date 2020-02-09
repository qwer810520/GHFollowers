//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/9.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
  func didTapGitHubProfile(for user: User)
  func didTapGetFollowers(for user: User)
}

class UserInfoViewController: UIViewController {

  var username: String?
  let headerView = UIView()
  let itemViewOne = UIView()
  let itemViewTwo = UIView()
  let dateLabel = GFBodyLabel(textAlignment: .center)

  var itemViews: [UIView] = []
  weak var delegate: FollowerListViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    layoutUI()
    getUserInfo()
  }

  func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }

  func getUserInfo() {
    NetworkManager.shared.getUserInfo(for: username ?? "") { [weak self] result in
      guard let self = self else { return }
      switch result {
        case .success(let user):
          DispatchQueue.main.async { self.configureUIElements(with: user) }
        case .failure(let error):
          self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }

  func configureUIElements(with user: User) {
    let repoItenVC = GFRepoItemViewController(user: user)
    repoItenVC.delegate = self

    let followerItemVC = GFFollowerItemViewController(user: user)
    followerItemVC.delegate = self

    self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)

    self.add(childVC: repoItenVC, to: self.itemViewOne)
    self.add(childVC: followerItemVC, to: self.itemViewTwo)
    self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
  }

  func layoutUI() {
    itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]

    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140

    for itemView in itemViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      ])
    }

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180),

      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
      dateLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }

  func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }

  @objc func dismissVC() {
    dismiss(animated: true)
  }
}

  // MARK: - UserInfoViewControllerDelegate

extension UserInfoViewController: UserInfoViewControllerDelegate {
  func didTapGitHubProfile(for user: User) {
    guard let url = URL(string: user.htmlUrl) else {
      presentGFAlertOnMainThread(title: "Invalid URL", message: "Thr url attached to this user is invalid.", buttonTitle: "OK")
      return
    }

    presentSafariVC(with: url)
  }

  func didTapGetFollowers(for user: User) {
    guard user.followers != 0 else {
      presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame 😞", buttonTitle: "So sad")
      return
    }
    delegate?.didRequestFollowers(for: user.login)
    dismissVC()
  }
}
