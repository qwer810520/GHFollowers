//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Min on 2020/2/9.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  convenience init(fontSize: CGFloat) {
    self.init(frame: .zero)
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods

  private func configure() {
    textColor = .secondaryLabel
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.9
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }
}
