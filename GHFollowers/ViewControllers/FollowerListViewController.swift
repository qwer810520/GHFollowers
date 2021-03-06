//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/6.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class FollowerListViewController: GFDataLoadingViewController {

  enum Section { case main }

  var username: String?
  var followers = [Follower]()
  var filteredFollowers = [Follower]()
  var page = 1

  var hasMoreFollowers = true
  var isSearching = false
  var isLoadingMoreFollowers = false

  var collectionView: UICollectionView!
  var dataSourece: UICollectionViewDiffableDataSource<Section, Follower>!

  init(username: String) {
    super.init(nibName: nil, bundle: nil)
    self.username = username
    title = username
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollowers(username: username ?? "", page: page)
    configureDataSource()
    configureSearchController()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    navigationItem.rightBarButtonItem = addButton
  }

  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }

  func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Search for a username"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }

  func getFollowers(username: String, page: Int) {
    showLoadingView()
    isLoadingMoreFollowers = true
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadingView()
      switch result {
        case .success(let followers):
          self.updateUI(with: followers)
        case .failure(let error):
          self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
      }

      self.isLoadingMoreFollowers = false
    }
  }

  func updateUI(with followers: [Follower]) {
    if followers.count < 100 {
      self.hasMoreFollowers = false
    }

    self.followers.append(contentsOf: followers)
    if followers.isEmpty {
      let message = "This user doesn't have any followers. Go follow them 😀"
      DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
      return
    }
    updateData(on: followers)
  }

  func configureDataSource() {
    dataSourece = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
      cell.set(follower: follower)
      return cell
    })
  }

  func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)

    DispatchQueue.main.async {
      self.dataSourece.apply(snapshot, animatingDifferences: true)
    }
  }

  @objc func addButtonTapped() {
    showLoadingView()
    NetworkManager.shared.getUserInfo(for: username ?? "") { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadingView()
      switch result {
        case .success(let user):
          self.addUserToFavorites(user: user)
        case .failure(let error):
          self.presentGFAlertOnMainThread(title: "Something want wrong", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }

  func addUserToFavorites(user: User) {
    let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
    PersistenceManager.updateWith(favorite: favorite, actionType: .add) { error in
      guard let error = error else {
        self.presentGFAlertOnMainThread(title: "Success!", message: "you have successFully favorited this user 🎉", buttonTitle: "Hooray!")
        return
      }

      self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
    }
  }
}

  // MARK: - UICollectionViewDelegate

extension FollowerListViewController: UICollectionViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height

    if offsetY > contentHeight - height {
      guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
      page += 1
      getFollowers(username: username ?? "", page: page)
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeArray = isSearching ? filteredFollowers : followers
    let follower = activeArray[indexPath.item]

    let userInfoVC = UserInfoViewController()
    userInfoVC.delegate = self
    userInfoVC.username = follower.login
    let naviController = UINavigationController(rootViewController: userInfoVC)
    present(naviController, animated: true)
  }
}

  // MARK: - UISearchResultsUpdating

extension FollowerListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else {
      filteredFollowers.removeAll()
      isSearching = false
      updateData(on: followers)
      return
    }

    isSearching = true
    filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
    updateData(on: filteredFollowers)
  }
}

  // MARK: - UserInfoViewControllerDelegate

extension FollowerListViewController: UserInfoViewControllerDelegate {
  func didRequestFollowers(for username: String) {
    self.username = username
    title = username
    page = 1
    
    followers.removeAll()
    filteredFollowers.removeAll()
    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    getFollowers(username: username, page: page)
  }
}
