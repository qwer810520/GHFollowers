//
//  UITableView+Extension.swift
//  GHFollowers
//
//  Created by Min on 2020/2/12.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

extension UITableView {

  func reloadDateOnMainThread() {
    DispatchQueue.main.async { self.reloadData() }
  }

  func removeExcessCells() {
    tableFooterView = UIView(frame: .zero)
  }
}
