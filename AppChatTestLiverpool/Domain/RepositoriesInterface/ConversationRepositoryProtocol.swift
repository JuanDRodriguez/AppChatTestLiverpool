//
//  ConversationRepositoryProtocol.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
protocol ConversationRepositoryProtocol{
    func fetchConversations(completion:@escaping CompletionHandler<[Conversation]>)
    func fetchUser(completion:@escaping CompletionHandler<[User]>)
}
