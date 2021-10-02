//
//  Users.swift
//  Speer_Tech
//
//  Created by Ravi Kanth Bollam on 2021-10-01.
//

import Foundation

struct UserProfile: Decodable {
    var username: String = ""
    var imageUrl: String = ""
    var followersUrl: String = ""
    var followingUrl: String = ""
    var name: String?
    var bio: String?
    var followers: Int = 0
    var following: Int = 0
    
    enum CodingKeys: String, CodingKey {
        
        case username = "login"
        case imageUrl = "avatar_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case name, bio, followers, following
    }
}

struct Follows: Decodable {
    var username: String = ""
    var imageUrl: String = ""
    
    enum CodingKeys: String, CodingKey{
        
        case username = "login"
        case imageUrl = "avatar_url"
    }
}

struct SearchUser: Decodable {
    var items: [Items]
    var count: Int = 0
    
    enum CodingKeys: String,CodingKey {
        case count = "total_count"
        case items
    }
}

struct Items: Decodable {
    var username: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case imageUrl = "avatar_url"
    }
}
