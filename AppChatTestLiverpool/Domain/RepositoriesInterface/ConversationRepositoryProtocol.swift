//
//  ConversationRepositoryProtocol.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
protocol ConversationRepositoryProtocol{
    func fetchConversations(completion:@escaping CompletionHandler<[Conversation]>)
    func fetchUsers(completion:@escaping CompletionHandler<[User]>)
    func fetchUser(idUser: String,completion:@escaping CompletionHandler<User>)
}
