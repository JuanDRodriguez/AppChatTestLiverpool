//
//  ChatViewModel.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import Foundation

protocol ChatViewModelOutput {
    var items: Observable<[Message]> { get }
}
protocol ChatViewModelInput{
    func loadMessagesChat()
}

class ChatViewModel: ChatViewModelInput  {
    
    let useCase: ChatUseCaseInput
    
    init(useCase: ChatUseCaseInput) {
        self.useCase = useCase
    }
    func loadMessagesChat() {
        
    }
    
    
}
