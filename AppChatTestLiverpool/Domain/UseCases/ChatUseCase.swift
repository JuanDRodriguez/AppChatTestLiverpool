//
//  ChatUseCase.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
protocol ChatUseCaseInput{
    func execute(completion: @escaping CompletionHandler<Bool>)
}
class ChatUseCase: ChatUseCaseInput {
    let repository: ChatRepositoryProtocol
    init(repository: ChatRepositoryProtocol) {
        self.repository = repository
    }
    func execute(completion: @escaping CompletionHandler<Bool>) {
        
    }
    
    
}
