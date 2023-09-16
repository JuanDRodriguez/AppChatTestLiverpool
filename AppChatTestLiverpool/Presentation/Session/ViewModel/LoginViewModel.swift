//
//  LoginViewModel.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
protocol LoginViewModelInput{
    func login( user: RequestUser)
}
protocol LoginViewModelOutput{
    func errorMesagge(title: String, message: String)
    func doneLogin(user: RequestUser)
}

class LoginViewModel:  LoginViewModelInput{
    let controller: LoginViewModelOutput
    let useCase: LoginUseCaseIntput
    init(controller: LoginViewModelOutput, useCase: LoginUseCaseIntput) {
        self.controller = controller
        self.useCase = useCase
    }
    
    func login(user: RequestUser) {
        self.useCase.execute(user: user){ response, error in
            guard let success = response, success else {
                let messageError = error as? AuthErrors ?? AuthErrors.FailedLogin
                self.controller.errorMesagge(title: "", message: messageError.errorString )
                return
            }
            self.controller.doneLogin(user: user)
        }
    }
    
    
}
