//
//  ChatRepository.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
class ChatRepository: ChatRepositoryProtocol{
    let databaseService: DatabaseServiceProtocol
    init(databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }
    func fectMessages() {
        
    }
    
    func createConversation() {
        
    }
    
    func sendMessage() {
        
    }
    
    
}
