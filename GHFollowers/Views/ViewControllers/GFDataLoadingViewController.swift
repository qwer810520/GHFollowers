//
//  GFDataLoadingViewController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/12.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFDataLoadingViewController: UIViewController {

  var containerView: UIView!

  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)

    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0

    UIView.animate(withDuration: 0.25) { [weak self] in
      self?.containerView.alpha = 0.8
    }

    let activityIndicator = UIActivityIndicatorView(style: .large)

    containerView.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
    ])

    activityIndicator.startAnimating()
  }

  func dismissLoadingView() {
    DispatchQueue.main.async {
      self.containerView.removeFromSuperview()
      self.containerView = nil
    }
  }

  func showEmptyStateView(with message: String, in view: UIView) {
    let emptyStateView = GFEmptyStateView(message: message)
    emptyStateView.frame = view.bounds
    view.addSubview(emptyStateView)
  }
}
