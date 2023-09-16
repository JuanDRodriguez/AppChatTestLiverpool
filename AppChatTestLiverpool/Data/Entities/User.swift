//
//  User.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import MessageKit
import UIKit

struct User: SenderType, Equatable, Codable {
    var senderId: String
    var displayName: String
    var urlImage: String
    enum CodingKeys:String,CodingKey {
        case senderId = "email"
        case displayName = "name"
        case urlImage = "photo"
    }
}
struct RequestUser: Codable{
    var senderId: String
    var displayName: String
    var password: String?
    enum CodingKeys:String,CodingKey {
        case senderId = "email"
        case displayName = "name"
        case password = "password"
    }
}
struct UsersRegistered: Codable{
    var users: [User]
    enum CodingKeys:String,CodingKey {
        case users = "users"
    }
}
struct Profile {
    var user: User
   
    
}
