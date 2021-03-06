//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by Min on 2020/2/11.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFAlertContainerView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods

  private func configure() {
    backgroundColor = .systemBackground
    layer.cornerRadius = 16
    layer.borderWidth = 2
    layer.borderColor = UIColor.white.cgColor
    translatesAutoresizingMaskIntoConstraints = false
  }
}

