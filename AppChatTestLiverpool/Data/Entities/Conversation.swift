//
//  Conversation.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
struct Conversation: Codable {
    let id: String
    let recipient: User
    let latestMessage: LatestMessage
    enum CodingKeys:String,CodingKey {
        case id = "id"
        case latestMessage = "latestMessage"
        case recipient = "recipient"
        
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
