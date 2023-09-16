//
//  Conversation.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
struct Conversation: Codable {
    let id: String
    let name: String
    let otherUserEmail: String
    let urlImage: String
    let latestMessage: LatestMessage
    enum CodingKeys:String,CodingKey {
        case id = "id"
        case name = "name"
        case otherUserEmail = "otherUser"
        case latestMessage = "latestMessage"
        case urlImage = "photo"
        
    }
}

struct LatestMessage: Codable{
    let date: String
    let text: String
    let isRead: Bool
    enum CodingKeys:String,CodingKey {
        case date = "date"
        case text = "message"
        case isRead = "isRead"
    }
}
