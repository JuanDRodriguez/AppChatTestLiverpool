//
//  LoginRepository.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import Foundation
protocol LoginRepositoryPortocol{
    func login(user: String, password: String, completion: @escaping CompletionHandlerAuth)
}
