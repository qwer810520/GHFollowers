//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/5.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class FavoritesListViewController: GFDataLoadingViewController {

  let tableView = UITableView()
  var favorites = [Follower]()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavorites()
  }

  func configureViewController() {
    view.backgroundColor = .systemBackground
    title = "Favorites"
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func configureTableView() {
    view.addSubview(tableView)

    tableView.frame = view.bounds
    tableView.rowHeight = 80
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)

    tableView.removeExcessCells()
  }

  func getFavorites() {
    PersistenceManager.retrieveFavorites { [weak self] result in
      guard let self = self else { return }
      switch result {
        case .success(let favorites):
          self.updateUI(with: favorites)
        case .failure(let error):
          self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }

  func updateUI(with favorites: [Follower]) {
    if favorites.isEmpty {
      showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: view)
    } else {
      self.favorites = favorites
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.view.bringSubviewToFront(self.tableView)
      }
    }
  }
}

  // MARK: - UITableViewDelegate

extension FavoritesListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let favorite = favorites[indexPath.row]
    let destVC = FollowerListViewController(username: favorite.login)
    navigationController?.pushViewController(destVC, animated: true)
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }

    let favorite = favorites[indexPath.row]

    PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
      guard let self = self else { return }
      guard let error = error else {
        self.favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        return
      }
      self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
    }
  }
}

  // MARK: - UITableViewDataSource

extension FavoritesListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
    cell.set(favorite: favorites[indexPath.row])
    return cell
  }
}
