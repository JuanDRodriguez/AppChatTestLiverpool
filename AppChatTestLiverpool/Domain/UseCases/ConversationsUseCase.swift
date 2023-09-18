//
//  ConversationsUseCase.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
protocol ConversationUseCaseProtocol{
    func execute(completion:@escaping CompletionHandler<[Conversation]>)
    func execute(completionHandler: @escaping CompletionHandler<[User]>)
    func execute(idUser: String, completionHandler: @escaping CompletionHandler<User>)
}

class ConversationUseCase: ConversationUseCaseProtocol{
    func execute(idUser: String, completionHandler: @escaping CompletionHandler<User>) {
        self.repository.fetchUser(idUser: idUser, completion: completionHandler)
    }
    
    
    var repository: ConversationRepository
    init(repository: ConversationRepository) {
        self.repository = repository
    }
    func execute(completion: @escaping CompletionHandler<[Conversation]>) {
        self.repository.fetchConversations(completion: completion)
    }
    
    func execute(completionHandler: @escaping CompletionHandler<[User]>) {
        self.repository.fetchUsers(completion: completionHandler)
    }
    
}
