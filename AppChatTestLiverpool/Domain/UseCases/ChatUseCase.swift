//
//  ChatUseCase.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
protocol ChatUseCaseInput{
    func execute(sender: User, conversation: Conversation,completion: @escaping CompletionHandler<Bool>)
    func execute(idConversation: String, message: MessageDTO,completion: @escaping CompletionHandler<Bool>)
    func execute(idConversation:String, completion: @escaping CompletionHandler<[MessageDTO]>)
}
class ChatUseCase: ChatUseCaseInput {
    func execute(sender: User, conversation: Conversation, completion: @escaping CompletionHandler<Bool>) {
        self.repository.createConversation(sender: sender, conversation: conversation,  completion: completion)
    }
    
    func execute(idConversation: String, message: MessageDTO, completion: @escaping CompletionHandler<Bool>) {
        self.repository.sendMessage(idConversation: idConversation, message: message, completion: completion)
    }
    
    func execute(idConversation:String, completion: @escaping CompletionHandler<[MessageDTO]>) {
        self.repository.fectMessages(idConversation: idConversation, completion: completion)
    }
    
    let repository: ChatRepositoryProtocol
    init(repository: ChatRepositoryProtocol) {
        self.repository = repository
    }
    func execute(completion: @escaping CompletionHandler<Bool>) {
        
    }
    
    
}
