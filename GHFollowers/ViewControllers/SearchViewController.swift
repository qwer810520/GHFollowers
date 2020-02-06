//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/5.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

  let logoimageView = UIImageView()
  let userNameTextField = GFTextField()
  let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

  var isUsernameEntered: Bool {
    return !(userNameTextField.text?.isEmpty ?? true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureLogoImageView()
    configureTextField()
    configureCallToActionButton()
    createDismisskeyboardTapGesture()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }

  func createDismisskeyboardTapGesture() {
    let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
    view.addGestureRecognizer(tap)
  }

  func configureLogoImageView() {
    view.addSubview(logoimageView)
    logoimageView.translatesAutoresizingMaskIntoConstraints = false
    logoimageView.image = UIImage(named: "gh-logo")

    NSLayoutConstraint.activate([
      logoimageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoimageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoimageView.heightAnchor.constraint(equalToConstant: 200),
      logoimageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }

  func configureTextField() {
    view.addSubview(userNameTextField)

    userNameTextField.delegate = self

    NSLayoutConstraint.activate([
      userNameTextField.topAnchor.constraint(equalTo: logoimageView.bottomAnchor, constant: 48),
      userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      userNameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  func configureCallToActionButton() {
    view.addSubview(callToActionButton)

    callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  // MARK: - Action Methods

  @objc func pushFollowerListVC() {
    guard isUsernameEntered else { return }
    let followerListVC = FollowerListViewController()
    followerListVC.userName = userNameTextField.text
    followerListVC.title = userNameTextField.text
    navigationController?.pushViewController(followerListVC, animated: true)
  }
}

  // MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pushFollowerListVC()
    return true
  }
}
