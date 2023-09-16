//
//  LoginUseCase.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation

protocol LoginUseCaseIntput{
    func execute(user: RequestUser,  completion: @escaping CompletionHandlerAuth)
}
struct LoginUseCase: LoginUseCaseIntput{
    let repository: LoginRepositoryPortocol
    init(repository: LoginRepositoryPortocol) {
        self.repository = repository
    }
    func execute(user: RequestUser, completion: @escaping CompletionHandlerAuth) {
        self.repository.login(user: user.senderId, password: user.password!, completion: completion)
    }
    
    
}
