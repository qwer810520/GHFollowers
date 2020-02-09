//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Min on 2020/2/8.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

  let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
  let logoImageView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(message: String) {
    super.init(frame: .zero)
    messageLabel.text = message
    configure()
  }

  // MARK: - Private Methods

  private func configure() {
    addSubview(messageLabel)
    addSubview(logoImageView)

    messageLabel.numberOfLines = 3
    messageLabel.textColor = .secondaryLabel

    logoImageView.image = UIImage(named: "empty-state-logo")
    logoImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
      messageLabel.heightAnchor.constraint(equalToConstant: 200),

      logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
      logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
      logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
      logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
    ])
  }
}