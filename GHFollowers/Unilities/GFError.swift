//
//  GFError.swift
//  GHFollowers
//
//  Created by Min on 2020/2/8.
//  Copyright © 2020 Min. All rights reserved.
//

import Foundation

enum GFError: String, Error {
  
  case invalidUsername = "This username created an invalid request. Pleace try again."
  case unableToComplete = "Unable to complete your request. Pleace check yout internet connection."
  case invalidResponse = "invalid response from the server. Pleace try again."
  case invalidData = "The data reviced from the server was invalid. Pleace try again."
  case unableToFavorite = "There was an error favoriting this user. Please try again."
  case alreadyInFavoirtes = "You've already favorited this user. You must REALLY like them!"
}
