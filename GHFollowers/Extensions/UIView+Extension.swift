//
//  UIView+Extension.swift
//  GHFollowers
//
//  Created by Min on 2020/2/12.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views { addSubview(view) }
  }

  func pinToEdges(of superview: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superview.topAnchor),
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor)
    ])
  }
}
