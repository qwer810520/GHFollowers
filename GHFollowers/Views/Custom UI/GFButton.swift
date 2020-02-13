//
//  GFButton.swift
//  GHFollowers
//
//  Created by Min on 2020/2/6.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  convenience init(backgroundColor: UIColor, title: String) {
    self.init(frame: .zero)
    self.backgroundColor = backgroundColor
    setTitle(title, for: .normal)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(backgroundColor: UIColor, title: String) {
    self.backgroundColor = backgroundColor
    setTitle(title, for: .normal)
  }

  // MARK: - Private Methods

  private func configure() {
    layer.cornerRadius = 10
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    setTitleColor(.white, for: .normal)
    translatesAutoresizingMaskIntoConstraints = false
  }
}
