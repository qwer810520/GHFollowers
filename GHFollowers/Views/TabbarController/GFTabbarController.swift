//
//  GFTabbarController.swift
//  GHFollowers
//
//  Created by Min on 2020/2/11.
//  Copyright © 2020 Min. All rights reserved.
//

import UIKit

class GFTabbarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    UITabBar.appearance().tintColor = .systemGreen
    viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
  }

  func createSearchNavigationController() -> UINavigationController {
    let searchVC = SearchViewController()
    searchVC.title = "Search"
    searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    return UINavigationController(rootViewController: searchVC)
  }

  func createFavoritesNavigationController() -> UINavigationController {
    let favaritesVC = FavoritesListViewController()
    favaritesVC.title = "Favarites"
    favaritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    return UINavigationController(rootViewController: favaritesVC)
  }
}
