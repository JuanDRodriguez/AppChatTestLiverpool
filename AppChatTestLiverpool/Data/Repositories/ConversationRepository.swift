//
//  ConversationRepository.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
class ConversationRepository: ConversationRepositoryProtocol{
    
    let databaseService: DatabaseServiceProtocol
    let id: String
    init(databaseService: DatabaseServiceProtocol, id: String) {
        self.databaseService = databaseService
        self.id = id
    }
    func fetchConversations(completion: @escaping CompletionHandler<[Conversation]>) {
        let path = String(format: StoragePath.conversations.rawValue, id)
        self.databaseService.request(path: path, parameters: nil, decodable: [Conversation](), method: .get, completion: completion)
    }
    
    func fetchUser(completion: @escaping CompletionHandler<[User]>) {
        let path = "\(StoragePath.registeredUsers.rawValue)/users"
        
        self.databaseService.request(path: path, parameters: nil, decodable: [User](), method: .getArray, completion: completion)
    }
    
}
