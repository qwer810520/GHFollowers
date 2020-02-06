//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/6.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController {

  var userName: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
