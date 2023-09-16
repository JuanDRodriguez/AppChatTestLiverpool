//
//  CreateProfileUseCase.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 14/09/23.
//

import Foundation
protocol CreateProfileUseCaseIntput{
    func execute(user: RequestUser, image: Data?, completion: @escaping CompletionHandler<Bool>)
}

struct CreateProfileUseCase: CreateProfileUseCaseIntput {
    let repository: ProfileRepositoryProtocol
    init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    func execute(user: RequestUser, image: Data?, completion: @escaping CompletionHandler<Bool>)
    {
        repository.createProfile(image: image, user: user, completion: completion)
    }
    
}
