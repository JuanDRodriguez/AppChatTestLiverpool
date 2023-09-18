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
    
    func fectMessages(idConversation: String, completion: @escaping CompletionHandler<[MessageDTO]>) {
        let path = String(format: StoragePath.messages.rawValue, idConversation)
        self.databaseService.request(path: path, parameters: nil, decodable: [MessageDTO](), method: .observing, completion: completion)
    }
    
    func createConversation(sender:User, conversation: Conversation, completion: @escaping CompletionHandler<Bool>) {
        self.fetchConversations(id: sender.senderId){
            result in
            switch result{
                
            case .success(let list):
                var conversations: [Conversation] = []
                if let listConversations  = list{
                    conversations =  listConversations.filter({ c in
                        return c.id != conversation.id
                    })
                }
                conversations.append(conversation)
                let path = String(format: "\( StoragePath.users.rawValue)", sender.senderId)
                let parameters = ["conversations":conversations.arrayDictionary!,
                                      "email":sender.senderId,
                                      "name": sender.displayName,
                                  "photo": sender.urlImage] as [String : Any] 
                    self.databaseService.request(path: path, parameters: parameters, decodable: Bool(), method: .set, completion: completion)
                
                break
            case .failure(_):
                break
            }
        }
        
    }
    
    func sendMessage(idConversation: String, message: MessageDTO, completion: @escaping CompletionHandler<Bool>) {
        
        self.fetchMessages(id: idConversation){
            result in
            switch result{
                
            case .success(let messages):
               
                    var newMessages: [MessageDTO] = []
                if let list = messages {
                    newMessages = list
                }
                    newMessages.append(message)
                    let path = String(format: "conversations/%@", idConversation)
                    print(path)
                    let parameters = ["messages":newMessages.arrayDictionary] as? [String : Any]
                    self.databaseService.request(path: path, parameters: parameters, decodable: Bool(), method: .set, completion: completion)
              
                break
            case .failure(_):
                break
            }
        }
        
        
    }
    func fetchConversations(id:String, completion: @escaping CompletionHandler<[Conversation]>){
        let path = String(format: StoragePath.conversations.rawValue, id)
        self.databaseService.request(path: path, parameters: nil, decodable: [Conversation](), method: .getArray, completion: completion)
    }
    func fetchMessages(id:String, completion: @escaping CompletionHandler<[MessageDTO]>){
        let path = String(format: StoragePath.messages.rawValue, id)
        self.databaseService.request(path: path, parameters: nil, decodable: [MessageDTO](), method: .getArray, completion: completion)
        
    }
   
}
