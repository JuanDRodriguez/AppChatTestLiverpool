//
//  ConversationsViewModel.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import Foundation
protocol ConversationViewModelOutput{
    var conversations: Observable<[Conversation]?> { get set }
    var users:  Observable<[User]?> { get set }
    func getUsers()
    func getConvertationValidExisting()
    func getUser()
    var sender: Observable<User?> { get set }
    func getConversations()
}
protocol ConversationViewModelInput{
    
}

typealias ConversationsViewModelProtocols = ConversationViewModelOutput & ConversationViewModelInput

class ConversationViewModel: ConversationsViewModelProtocols{
    
    
    func getConvertationValidExisting() {
        
    }
    
    var users: Observable<[User]?> = Observable([])
    var conversations: Observable<[Conversation]?> = Observable([])
    var id: String?
    var sender: Observable<User?> = Observable(User(senderId: "", displayName: "", urlImage: ""))
    let usecase: ConversationUseCaseProtocol
    
    init(usecase: ConversationUseCaseProtocol) {
        self.usecase = usecase
    }
    func getUser() {
        self.usecase.execute(idUser: id ?? ""){result in
            switch result{
                
            case .success(let user):
                self.sender.value = user
                break
            case .failure(_):
                print("fail fetch my user")
                break
            }
        }
    }
    func getUsers() {
        usecase.execute(){ result in
            switch result{
                
            case .success(let response):
               guard let listUsers = response else{
                    return
                }
                self.users.value = listUsers.filter({
                    return $0.senderId != self.id
                })
                break
            case .failure(_):
                break
            }
            
        }
    }
    
    func getConversations() {
        usecase.execute(){ result in
            switch result{
                
            case .success(let response):
                guard let items = response else{
                    return
                }
                
                self.conversations.value = items
                break
            case .failure(_):
                break
            }
            
        }
    }
   
}
