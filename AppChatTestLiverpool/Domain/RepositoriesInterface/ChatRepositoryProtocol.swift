//
//  ChatRepositoryProtocol.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
protocol ChatRepositoryProtocol{
    func fectMessages(idConversation: String, completion: @escaping CompletionHandler<[MessageDTO]> )
    func createConversation(sender: User,conversation: Conversation,completion: @escaping CompletionHandler<Bool>)
    func sendMessage(idConversation:String, message: MessageDTO, completion: @escaping CompletionHandler<Bool>)
}
