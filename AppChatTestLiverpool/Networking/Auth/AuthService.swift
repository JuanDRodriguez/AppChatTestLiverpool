//
//  AuthService.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 14/09/23.
//

import Foundation
import FirebaseAuth
typealias CompletionHandlerAuth  = (Bool?, Error?) -> Void
protocol AuthServiceProtocol{
    func signIn(user: String, password: String, completion: @escaping CompletionHandlerAuth)
    func singup(user: String, password: String, completion: @escaping CompletionHandlerAuth)
}
class AuthService: AuthServiceProtocol{
    let auth = FirebaseAuth.Auth.auth()
    func signIn(user: String, password: String, completion: @escaping CompletionHandlerAuth) {
        auth.signIn(withEmail: user, password: password){authResult, error in
           
            guard authResult != nil, error == nil else{
                completion(nil,AuthErrors.FailedLogin)
                return
            }
            completion(true,nil)
        }
    }
    
    func singup(user: String, password: String, completion: @escaping CompletionHandlerAuth) {
        auth.createUser(withEmail: user, password: password){
            authResult, error in
                guard authResult != nil, error == nil else {
                    completion(nil,AuthErrors.failedCreateUser)
                    return
                }
            completion(true,nil)
        }
    }
    
    			
}
