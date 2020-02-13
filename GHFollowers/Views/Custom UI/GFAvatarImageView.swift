//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Min on 2020/2/8.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

  let cache = NetworkManager.shared.cache
  let placeholderImage = Images.placeHolder

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods

  private func configure() {
    contentMode = .scaleAspectFit
    clipsToBounds = true
    layer.cornerRadius = 10
    image = placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
  }

  // MARK: - API Methods

  func downloadImage(fromURL url: String) {
    NetworkManager.shared.downloadImage(from: url) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.image = image
      }
    }
  }

}
