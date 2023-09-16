//
//  Message.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: MessageKit.SenderType{
        user
    }
    private init(kind: MessageKind, user: User, messageId: String, date: Date) {
      self.kind = kind
      self.user = user
      self.messageId = messageId
      sentDate = date
    }
    init(text: String, user: User, messageId: String, date: Date) {
      self.init(kind: .text(text), user: user, messageId: messageId, date: date)
    }
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKit.MessageKind
    
    var user: User
}
