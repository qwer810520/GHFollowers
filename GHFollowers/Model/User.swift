//
//  User.swift
//  GHFollowers
//
//  Created by Min on 2020/2/8.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation

struct User: Codable {
  let login: String
  let avatarUrl: String
  var name: String?
  var location: String?
  var bio: String?
  let publicRepos: Int
  let publicGists: Int
  let htmlUrl: String
  let followers: Int
  let following: Int
  let createdAt: String
}
